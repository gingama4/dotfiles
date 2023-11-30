local default_opts = {}

return function(_, opts)
  local utils = require 'utils'
  local merge_opts = utils.extend_tbl(default_opts, opts)

  local lualine = require('lualine')
  lualine.setup(merge_opts)
end
