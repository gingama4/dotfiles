local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Which Key
later(function()
  add('folke/which-key.nvim')
  require('which-key').setup({
    preset = "helix",
    default = {},
  })
end)

later(function()
  add('https://github.com/vim-jp/vimdoc-ja')
  vim.opt.helplang:prepend('ja')
end)
