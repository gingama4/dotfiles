---@class util.skk
local M = {}

M.names = {
  eiji = "A",
  hira = "あ",
  kata = "ア",
  hankata = "ｱ",
  zenkaku = "Ａ",
  abbrev = "abbr",
}

function M.get_mode()
  local mode = vim.g["skkeleton#mode"]
  return M.names[mode] or M.names.eiji
end

function M.Mode()
  local mode = M.get_mode()

  return GinVim.icons.ime .. " " .. mode
end

return M
