vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Go to Left Window", remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Go to Lower Window", remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Go to Upper Window", remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Go to Right Window", remap = true })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- [_Lsp]
vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Lsp]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "[_Lsp]", {})
