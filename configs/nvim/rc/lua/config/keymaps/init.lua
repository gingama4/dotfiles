local function keymap(map)
  local default = { noremap = true, silent = true }

  local data = require("config.keymaps." .. map)
  local maps = GinVim.keymap.mapBuilder(data)

  for _, v in ipairs(maps) do
    local mode = v[1]
    local key = v[2]
    local action = v[3]
    local opts = v[4] or {}
    vim.keymap.set(mode, key, action, vim.tbl_extend("force", default, opts))
  end
end

keymap("window")
keymap("coding")
keymap("lsp")
keymap("terminal")
