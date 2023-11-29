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
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = require'plugins.configs.nvim-cmp',
  },
  {
    'folke/trouble.nvim',
    event = { "BufReadPost", "BufNewFile" },
  },
}

