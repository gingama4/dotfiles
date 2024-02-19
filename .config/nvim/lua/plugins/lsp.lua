return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = require 'plugins.configs.nvim-lspconfig',
  },
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPre', 'VimEnter' },
    build = ':MasonUpdate',
    config = require 'plugins.configs.mason',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'BufReadPre',
    config = require 'plugins.configs.mason-lspconfig',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
    config = require 'plugins.configs.nvim-cmp',
  },
  -- Lint
  {
    'mfussenegger/nvim-lint',
    envet = { 'BufReadPre' },
    config = require 'plugins.configs.nvim-lint',
  },
  -- Format
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre' },
    config = require 'plugins.configs.conform',
  },
}
