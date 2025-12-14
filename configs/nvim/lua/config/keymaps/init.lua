local function keymap(map)
  local data = require("config.keymaps." .. map)
  for _, v in ipairs(data) do
    GinVim.keymap.set(v)
  end
end

keymap("buffer")
keymap("window")
keymap("coding")
keymap("ui")
keymap("lsp")
keymap("terminal")
