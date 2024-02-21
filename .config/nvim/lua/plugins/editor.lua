return {
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function() require 'plugins.configs.Comment' end
  },
  {
    'hrsh7th/nvim-insx',
    event = 'BufReadPre',
    config = function() require 'plugins.configs.nvim-insx' end
  },
}
