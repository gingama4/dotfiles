local LazyUtil = require("lazy.core.util")

---@class gingama4.util: LazyUtilCore
---@field config GinVimConfig
---@field plugin gingama4.util.plugin
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    t[k] = require("gingama4.util." .. k)
    return t[k]
  end,
})
return M
