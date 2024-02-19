local M = {}
local lazy_util = require('lazy.core.util')

function M.import(path)
  local modnames = Import(path)

  local mods = {}
  for _, modname in ipairs(modnames) do
    mods[#mods + 1] = Import_config(modname)
  end

  return mods
end

function Import(path)
  local files = {}
  lazy_util.lsmod(path, function(file)
    files[#files + 1] = file
  end)
  table.sort(files)

  return files
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

return M
