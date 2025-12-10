pcall(function()
  vim.loader.enable()
end)
vim.uv = vim.uv or vim.loop
vim.tbl_islist = vim.islist

-- Plugin Manager
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})
require("mini.deps").setup()

-- Basic Config
local config = require("config")
config.setup()
_G.GinVim = config

-- Plugin Config
require("plugins.mini")
require("plugins.ui")
require("plugins.editor")
require("plugins.coding")
