return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = require'plugins.configs.nvim-lspconfig',
  },
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPre', 'VimEnter' },
    build = ':MasonUpdate',
    config = require'plugins.configs.mason',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'BufReadPre',
    config = require'plugins.configs.mason-lspconfig',
  },
}

