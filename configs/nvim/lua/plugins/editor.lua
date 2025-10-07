local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Which Key
later(function()
  add('folke/which-key.nvim')
  require('which-key').setup({
    preset = "helix",
    default = {},
  })
end)
