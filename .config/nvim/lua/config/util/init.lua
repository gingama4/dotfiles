local LazyUtil = require("lazy.core.util")

---@class config.util: LazyUtil
---@field config GinVimConfig
---@field format config.util.format
---@field lsp config.util.lsp
---@field plugin config.util.plugin
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end

    t[k] = require("config.util." .. k)
    return t[k]
  end,
})

---@param name string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param name string
function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

return M
