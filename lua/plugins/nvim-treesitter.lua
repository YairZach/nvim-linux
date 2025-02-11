local config = function()
  require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
  require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "markdown",
    "json",
    "javascript",
    "typescript",
    "html",
    "css",
    "lua",
    "dockerfile",
    "gitignore",
    "python",
    "c",
    "c_sharp",
    "cpp",
    "csv",
    "go",
    "http",
    "sql",
  },
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = { "html", "xml", "xaml" },
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
  },
})
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = config
}



