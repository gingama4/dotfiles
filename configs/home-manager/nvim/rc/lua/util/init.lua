---@class util
---@field icons util.icons
---@field plugin util.plugin
---@field skk util.skk
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util." .. k)
    return t[k]
  end,
})
return M
