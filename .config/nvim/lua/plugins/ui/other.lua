return {
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
}
