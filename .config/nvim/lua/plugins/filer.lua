return {
  {
    'lambdalisue/fern.vim',
    enabled = false,
    keys = {
      { "<leader>e", ":Fern . -reveal=% -drawer -toggle -width=40<CR>", desc = "toggle fern" },
    },
    dependencies = {
      { 'lambdalisue/nerdfont.vim' },
      { 'lambdalisue/fern-git-status.vim' },
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        config = function()
          vim.g['fern#renderer'] = "nerdfont"
        end
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "toggle neo-tree", silent = true },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'MunifTanjim/nui.nvim' },
    },
    opts = function ()
      return {}
    end,
    config = require'plugins.configs.neo-tree'
  },
}

