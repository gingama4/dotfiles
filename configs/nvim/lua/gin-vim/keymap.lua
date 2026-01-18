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

function M.set(map)
  local default = { noremap = true, silent = true }
  local v = M.builder(map)

  local mode = v[1]
  local key = v[2]
  local action = v[3]
  local opts = v[4] or {}
  vim.keymap.set(mode, key, action, vim.tbl_extend("force", default, opts))
end

return M
