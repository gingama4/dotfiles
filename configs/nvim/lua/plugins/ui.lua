local add = vim.pack.add
local now, later = MiniDeps.now, MiniDeps.later

-- Colorscheme
now(function()
  add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
  vim.cmd("colorscheme catppuccin")
end)

-- File Explorer
later(function()
  add({ { src = "https://github.com/stevearc/oil.nvim", name = "oil" } })
  require("oil").setup()
  GinVim.keymap.set({ "<leader>e", "<Cmd>Oil<CR>", desc = "Open Explorer" })
end)
