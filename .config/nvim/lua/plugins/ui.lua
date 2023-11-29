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
    'akinsho/toggleterm.nvim',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { '<leader>t', ':ToggleTerm direction=float<CR>' },
      { '<C-Space>t', ':ToggleTerm direction=horizontal<CR>' },
      { '<leader>g', '<cmd>lua __lazygit_toggle()<CR>' },
    },
    opts = {
      autochdir = true,
    },
    config = require 'plugins.configs.toggleterm'
  },
}

