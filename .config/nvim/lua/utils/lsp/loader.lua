local M = {}

local util = require('utils')
local config_util = require('utils.lsp.config')

function M.load()
  local lspconfig = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')
  local setup = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,
  }

  local configs = Load()

  for lsp, config in pairs(configs) do
    setup[lsp] = function ()
      lspconfig[lsp].setup(config)
    end
  end

  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers(setup)
end

function Load()
  local configs = Import('lsp')

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

return M
