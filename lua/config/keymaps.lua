local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--Directory navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", opts)
keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", opts)

--Pane navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

--Window managment
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split horazontally
keymap.set("n", "<leader>sm",":MaximizerToggle<CR>", opts) --Maximize/minimize pane

--Input
vim.api.nvim_set_keymap('i', '<C-Del>', '<C-o>dw', {noremap = true})

--Debugger
keymap.set("n", "<leader>dr", ":lua require'dap'.continue() <CR>", opts)
keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint() <CR>", opts)
keymap.set("n", "<F9>", ":lua require'dap'.step_over() <CR>", opts)
keymap.set("n", "<F10>", ":lua require'dap'.step_into() <CR>", opts)
keymap.set("n", "<F8>", "<CMD>lua require.('dapui').eval()", opts)
