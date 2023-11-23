local Ascii = {}
Ascii.gorilla = {
  [[        ."`".]],
  [[  .-./ _=_ \.-.]],
  [[ {  (,(oYo),) }}]],
  [[ {{ |   "   |} }]],
  [[ { { \(---)/  }}]],
  [[ {{  }'-=-'{ } }]],
  [[ { { }._:_.{  }}]],
  [[ {{  } -:- { } }]],
  [[ {_{ }`===`{  _}]],
  [[((((\)     (/))))]],
}

return {
  'goolord/alpha-nvim',
  --cmd = "Alpha",
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = function ()
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = Ascii.gorilla
    dashboard.section.header.opts.hl = 'DashboardHeader'
    dashboard.section.footer.opts.hl = 'DashboardFooter'

    local button = require('utils').alpha_button

    dashboard.section.buttons.val = {
      button("p", "  Update Plugins", ":Lazy sync<CR>"),
      button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.config.layout = {
      { type = "padding", val = function() return math.floor(vim.o.lines * 0.25) end },
      dashboard.section.header,
      { type = "padding", val = 5 },
      dashboard.section.buttons,
      { type = "padding", val = 3 },
      dashboard.section.footer,
    }
    dashboard.config.opts.noautocmd = true
    return dashboard
  end,
  config = require 'plugins.configs.alpha',
}

