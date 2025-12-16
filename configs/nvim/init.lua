pcall(function()
  vim.loader.enable()
end)
vim.uv = vim.uv or vim.loop
vim.tbl_islist = vim.islist

-- Plugin Manager
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})

-- Bootstrap
require("mini.deps").setup()

local GinVim = require("gin-vim")
_G.GinVim = GinVim

-- Basic Config
require("config.options")
require("config.keymaps")

-- Plugin Config
require("mini")
require("plugins")
