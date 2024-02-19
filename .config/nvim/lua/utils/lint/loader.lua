local M = {}

local util = require('utils')
local Import = require('utils.loader').import
local config_util = require('utils.lint.config')

function M.load()
  local builtin_configs = Import('lint')
  local env_configs = Import('environment.lint')

  local configs = util.extend_tbl(builtin_configs, env_configs)

  local opts = {}
  for _, config in ipairs(configs) do
    local checked_config = config_util.setup(config)
    opts[checked_config.lint] = checked_config.settings
  end

  return opts
end

return M
