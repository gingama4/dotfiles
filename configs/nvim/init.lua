pcall(function()
  vim.loader.enable()
end)
vim.uv = vim.uv or vim.loop
vim.tbl_islist = vim.islist

-- Basic Config
require("config.options")
require("config.keymaps.init")

-- Plugin Manager
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})
require("mini.deps").setup()

local GinVim = require("gin-vim")
_G.GinVim = GinVim

-- Plugin Config
require("plugins.mini")
require("plugins.ui")
require("plugins.editor")
require("plugins.coding")
