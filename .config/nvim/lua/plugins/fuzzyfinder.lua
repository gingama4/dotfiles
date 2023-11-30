return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = {
      'Telescope',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { '<leader>m', ':Telescope marks<cr>', desc = 'search by [M]arks' },
      { '<C-p>', ':Telescope find_files<cr>', desc = 'search Files' },
    },
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-tree/nvim-web-devicons',
      },
    },
    opts = function()
      local actions = require 'telescope.actions'
      return {
        defaults = {
          path_display = { 'truncate ' },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      }
    end,
    config = require 'plugins.configs.telescope',
  },
}

