return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'BufReadPre',
    config = function()
      require('plugins.configs.copilot')
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'BufReadPre',
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatToggle',
    },
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      }
    },
    opts = {
      debug = true,
    },
 }
}
