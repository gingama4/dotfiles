local M = {}

local util = require('utils')

M.format = {
  formatters = {},
  formatters_by_ft = {},
}

function M.setup(opts)
  local config = util.extend_tbl(M.format, opts)

  return config
end

return M
