vim.uv = vim.uv or vim.loop

local M = {}

function M.setup()
  require("gingama4.config.lazy")
  require("gingama4.config").setup()
end

return M
