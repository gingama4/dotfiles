local M = {}

local util = require('utils')

M.format = {
  lint = nil,
  settings = {},
}

function M.setup(opts)
  local config = util.extend_tbl(M.format, opts)

  if config.lint == nil then
    error('Lint config needs "lint".')
  end

  return config
end

return M
