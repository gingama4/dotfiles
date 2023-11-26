local M = {}

local util = require('utils')
local lazy_util = require('lazy.core.util')
local config_util = require('utils.lsp.config')

function M.load()
  local defaults = import('lsp')
  local workspaces = import_workspace()
  local configs = util.extend_tbl(defaults, workspaces)

  local opts = {}
  for _, config in ipairs(configs) do
    local checked_config = config_util.setup(config)
    opts[checked_config.lsp] = checked_config.settings
  end

  return opts
end

function import(path)
  local modnames = {}
  lazy_util.lsmod(path, function(modname)
    modnames[#modnames + 1] = modname
  end)
  table.sort(modnames)

  local mods = {}
  for _, modname in ipairs(modnames) do
    mods[#mods + 1] = import_config(modname)
  end

  return mods
end

function import_config(modname)
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

function import_workspace()
  local workspaces = require('workspaces')
  local workspace = workspaces.name()
  if not workspace then
    return {}
  end

  return import('lsp.' .. workspace)
end

return M
