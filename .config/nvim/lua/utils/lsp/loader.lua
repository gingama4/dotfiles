local M = {}

local util = require('utils')
local config_util = require('utils.lsp.config')

function M.load()
  local defaults = Import('lsp')
  local workspaces = Import_workspace()
  local configs = util.extend_tbl(defaults, workspaces)

  local opts = {}
  for _, config in ipairs(configs) do
    local checked_config = config_util.setup(config)
    opts[checked_config.lsp] = checked_config.settings
  end

  return opts
end

function Import(path)
  local loader = require 'utils.loader'
  local modnames = loader.import(path)

  local mods = {}
  for _, modname in ipairs(modnames) do
    mods[#mods + 1] = Import_config(modname)
  end

  return mods
end

function Import_config(modname)
  local mod = require(modname)
  if type(mod) ~= 'table' then
    error('Invalid lsp config: `'
      .. modname
      .. '`\nExpected a `table` of config, but a `'
      .. type(mod)
      .. '` was returned instead'
    )
  end
  return mod
end

function Import_workspace()
  local workspaces = require('workspaces')
  local workspace = workspaces.name()
  if not workspace then
    return {}
  end

  return Import('lsp.' .. workspace)
end

return M
