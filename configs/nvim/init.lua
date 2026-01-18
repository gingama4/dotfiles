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

-- Config
require("10_options")
require("11_keymaps")
require("12_commands")
require("20_vscode")
require("30_mini")
require("40_plugins")
