local on_attach = require("utils.lsp").on_attach

local config = function()
  require("neoconf").setup({})
  require'cmp'.setup {
    sources = {
      { name = 'nvim_lsp' }
    }
  }

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

	local lspconfig = require("lspconfig")

	local signs = { Error = " ", Warn = " ", Hint = " ", Info = "󰋼 " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, textchl = hl, numhl = "" })
	end

  --lua
	lspconfig.lua_ls.setup({
    capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIMR/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	--python
	lspconfig.pyright.setup({
    capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

  --golang
  lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls = {
        analysis = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  })

  --c/cpp
  lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "c", "cpp", },
    single_file_support = true,
    cmd = { "clangd" },
    arguments = {"-std=c++23"},
    root_dir = require("lspconfig.util").root_pattern(
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
      '.git'
    ),
  })

  --c#
  lspconfig.omnisharp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
 
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
  local golangci = require("efmls-configs.linters.golangci_lint")
  local gofumpt = require("efmls-configs.formatters.gofumpt")
  local cpplint = require("efmls-configs.linters.cpplint")
  local clang_format = require("efmls-configs.formatters.clang_format")
  local mcs = require("efmls-configs.linters.mcs")

	lspconfig.efm.setup({
		filetypes = {
			"lua",
      "python",
      "go",
      "c",
      "cpp",
      "c_sharp"
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
        python = { flake8, black },
        go = { golangci, gofumpt },
        cpp = { cpplint, clang_format },
        c = { cpplint, clang_format },
        c_sharp = { clang_format, mcs },
			},
		},
	})

	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
    "hrsh7th/cmp-nvim-lsp",
	},
}

