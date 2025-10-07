local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require('mini.icons').setup()
  later(MiniIcons.mock_nvim_web_devicons)
end)

now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.starter').setup() end)

