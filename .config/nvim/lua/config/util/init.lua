local LazyUtil = require("lazy.core.util")

---@class config.util: LazyUtil
---@field config GinVimConfig
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

return M
