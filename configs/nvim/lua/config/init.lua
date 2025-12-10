local M = {}

M.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

function M.setup()
  require("config.options")
  require("config.keymaps")
  local autocmds = require("config.autocmds")

  autocmds.setup()

  M.create_autocmd = autocmds.autocmd
end

return M
