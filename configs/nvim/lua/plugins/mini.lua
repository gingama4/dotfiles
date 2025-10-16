local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require('mini.basics').setup({
    options = {
      extra_ui = true,
    },
    mappings = {
      option_toggle_prefix = 'm',
    },
  })
end)

now(function()
  require('mini.icons').setup()
  later(MiniIcons.mock_nvim_web_devicons)
end)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify({})
end)

now(function() require('mini.tabline').setup() end)
now(function()
  require('mini.statusline').setup()
  vim.opt.laststatus = 3
end)
now(function() require('mini.starter').setup() end)

later(function() require('mini.cursorword').setup() end)

later(function() require('mini.indentscope').setup() end)

later(function()
  require('mini.misc').setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
end)

later(function () require('mini.pairs').setup() end)

later(function () require('mini.surround').setup() end)

