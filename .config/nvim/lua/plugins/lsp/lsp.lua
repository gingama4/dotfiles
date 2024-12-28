return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      {
        'zbirenbaum/copilot-cmp',
        config = true,
      },
      'saadparwaiz1/cmp_luasnip',
    },
    config = require 'plugins.configs.nvim-cmp',
  },
}
