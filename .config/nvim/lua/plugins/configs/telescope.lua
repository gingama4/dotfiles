return function(_,opts)
  local telescope = require 'telescope'

  telescope.setup(opts)
  telescope.load_extension('fzf')
  telescope.load_extension('workspaces')

  vim.keymap.set('n', '<leader>w', require('telescope.builtin').grep_string)
end
