local M = {}

M.augroup = vim.api.nvim_create_augroup("ginvim_config", { clear = true })

function M.create_autocmd(event, pattern, callback, desc)
  local opts = { group = M.augroup, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

M.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

M.luals_unique_definition = require("gin-vim.luals_unique")

local keymap = require("gin-vim.keymap")
M.keymap = keymap

return M
