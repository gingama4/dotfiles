local M = {}

local folder_confguration = {
  rc = 'rc',
  lsp = '',
}

local workspace = nil

function Path(folder)
  local root = 'workspaces'
  return root .. '.' .. workspace .. '.' .. folder
end

function Get_workspace()
  local workspaces = require('workspaces')
  local name = workspaces.name()
  return name
end

function Load_rc()
  local loader = require('utils.loader')
  local path = Path(folder_confguration.rc)
  local configs = loader.import(path)

  for _, config in ipairs(configs) do
    require(config)
  end
end

function M.load()
  local lsp = require('utils.lsp.loader')
  workspace = Get_workspace()
  if not workspace then
    return
  end

  Load_rc()
  lsp.load()
end

return M
