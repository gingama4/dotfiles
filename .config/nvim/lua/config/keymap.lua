vim.g.mapleader = ' '

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- [_Lsp]
vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Lsp]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "[_Lsp]", {})

