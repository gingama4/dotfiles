local M = {}

local util = require('utils')
local Import = require('utils.loader').import
local config_util = require('utils.format.config')

function M.load()
  local builtin_configs = Import('format')
  local env_configs = Import('environment.format')

  local configs = util.extend_tbl(builtin_configs, env_configs)

  local opts = {}
  for _, config in ipairs(configs) do
    local checked_config = config_util.setup(config)
    opts = util.extend_tbl(opts, checked_config)
  end

  return opts
end

return M
