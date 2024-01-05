local capabilities = vim.tbl_deep_extend('force',
  vim.lsp.protocol.make_client_capabilities(),
  {}
)

---@param names string[]
---@return string[]
local function get_plugin_paths(names)
  local plugins = require('lazy.core.config').plugins
  local paths = {}
  for _, name in ipairs(names) do
    if plugins[name] then
      table.insert(paths, vim.fs.joinpath(plugins[name].dir, 'lua'))
    else
      vim.notify('Invalid plugin name: ' .. name)
    end
  end
  return paths
end

---@param plugins string[]
---@return string[]
local function library(plugins)
  local paths = get_plugin_paths(plugins)
  table.insert(paths, vim.fs.joinpath(vim.fn.stdpath('config'), 'lua'))
  table.insert(paths, vim.fs.joinpath(vim.env.VIMRUNTIME, 'lua'))
  table.insert(paths, "${3rd}/luv/library")
  table.insert(paths, "${3rd}/busted/library")
  table.insert(paths, "${3rd}/luassert/library")
  return paths
end

return {
  lsp = 'lua_ls',
  settings = {
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          pathStrict = true,
          path = { '?.lua', '?/init.lua' }
        },
        workspace = {
          library = library({ 'lazy.nvim' }),
          checkThirdParty = 'Disable'
        },
        hint = { enable = true },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = 'tab',
            indent_size = '2',
          }
        },
      },
    },
  },
}

