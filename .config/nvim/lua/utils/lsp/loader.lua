local M = {}

local util = require('utils')
local Import = require('utils.loader').import
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
    setup[lsp] = function()
      lspconfig[lsp].setup(config)
    end
  end

  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers(setup)
end

function Load()
  local builtin_configs = Import('lsp')
  local env_configs = Import('environment.lsp')

  local configs = util.extend_tbl(builtin_configs, env_configs)

  local opts = {}
  for _, config in ipairs(configs) do
    local checked_config = config_util.setup(config)
    opts[checked_config.lsp] = checked_config.settings
  end

  return opts
end

return M
