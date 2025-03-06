local LazyUtil = require("lazy.core.util")

---@class util: LazyUtilCore
---@field config GinVimConfig
---@field plugin util.plugin
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    t[k] = require("util." .. k)
    return t[k]
  end,
})
return M
