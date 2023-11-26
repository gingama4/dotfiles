local M = {}

local util = require('utils')

M.format = {
  lsp = nil,
  settings = {},
}

function M.setup(opts)
  local config = util.extend_tbl(M.format, opts)

  if config.lsp == nil then
    error('Lsp config needs "lsp".')
  end

  return config
end

return M
