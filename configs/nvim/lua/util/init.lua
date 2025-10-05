---@class util
---@field icons util.icons
---@field keymap util.keymap
---@field language util.language
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util." .. k)
    return t[k]
  end,
})
return M
