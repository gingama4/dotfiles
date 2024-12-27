return {
  {
    'j-hui/fidget.nvim',
    event = 'VimEnter',
    config = function() require('fidget').setup() end,
  },
  {
    'akinsho/toggleterm.nvim',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { '<leader>t',  ':ToggleTerm direction=float<CR>' },
      { '<C-Space>t', ':ToggleTerm direction=horizontal<CR>' },
      { '<leader>g',  '<cmd>lua __lazygit_toggle()<CR>' },
    },
    opts = {
      autochdir = true,
    },
    config = require 'plugins.configs.toggleterm'
  },
  {
    'rcarriga/nvim-notify',
    event = "BufreadPre",
    config = require 'plugins.configs.nvim-notify',
  },
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
    },
    config = require 'plugins.configs.noice',
  },
}
