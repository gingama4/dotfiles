return {
  'natecraddock/workspaces.nvim',
  lazy = false,
  opts = {},
  config = function()
    require('workspaces').setup({
      hooks = {
        open = function ()
          local workspace = require 'utils.workspace'
          workspace.load()
        end,
      },
    })
  end,
}

