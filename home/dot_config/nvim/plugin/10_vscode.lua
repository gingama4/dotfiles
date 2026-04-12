if vim.g.vscode == nil then
  return
end

GinVim.keymap.set({ "]b", "<Cmd>Tabnext<CR>" })
GinVim.keymap.set({ "[b", "<Cmd>Tabprev<CR>" })
