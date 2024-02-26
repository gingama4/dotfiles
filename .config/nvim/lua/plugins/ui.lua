return {
  {
    'onsails/lspkind.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mode = 'symbol',
      symbol_map = {
        Array = "󰅪",
        Boolean = "⊨",
        Class = "󰌗",
        Constructor = "",
        Key = "󰌆",
        Namespace = "󰅪",
        Null = "NULL",
        Number = "#",
        Object = "󰀚",
        Package = "󰏗",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "󰀬",
        TypeParameter = "󰊄",
        Unit = "",
      },
      menu = {},
    },
    enabled = vim.g.icons_enabled,
    config = function(_, opts) require('lspkind').init(opts) end,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'VimEnter',
    config = function() require 'plugins.configs.lspsaga' end
  },
  {
    'folke/trouble.nvim',
    event = { "BufReadPost", "BufNewFile" },
  },
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
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    event = "BufreadPre",
    config = require 'plugins.configs.nvim-notify',
  },
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    config = require 'plugins.configs.noice',
  },
}
