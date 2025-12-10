local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Colorscheme
now(function()
  add({ source = "catppuccin/nvim", name = "catppuccin" })
  vim.cmd("colorscheme catppuccin")
end)

-- File Explorer
later(function()
  add({ source = "stevearc/oil.nvim", name = "oil" })
  require("oil").setup()
end)
