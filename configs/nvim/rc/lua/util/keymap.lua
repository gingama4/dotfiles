---@class util.keymap
local M = {}

function M.builder(map)
  local key = map["key"] or map[1]
  local action = map["action"] or map[2]
  local mode = map["mode"] or "n"
  local opts = map["opts"] or {}

  local desc = map["desc"] or nil
  if desc then
    opts["desc"] = desc
  end

  return {
    mode,
    key,
    action,
    opts,
  }
end

function M.mapBuilder(maps)
  local keymaps = {}
  for _, v in ipairs(maps) do
    table.insert(keymaps, M.builder(v))
  end
  return keymaps
end

return M
