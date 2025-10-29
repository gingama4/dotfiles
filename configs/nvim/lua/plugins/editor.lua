local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Mason
later(function()
  add('mason-org/mason.nvim')
  require('mason').setup()
end)

-- vimdoc-ja
later(function()
  add('vim-jp/vimdoc-ja')
  vim.opt.helplang:prepend('ja')
end)
