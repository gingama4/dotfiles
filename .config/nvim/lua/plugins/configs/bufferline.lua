return function(_, opts)
  local bufferline = require 'bufferline'
  bufferline.setup(opts)

  -- Overwrite default tab move keymap
  vim.keymap.set('n', 'gt', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', 'gT', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

  vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-l>', ':BufferLineMoveNext<CR>', { noremap = true, silent = false })
  vim.keymap.set('n', '<C-h>', ':BufferLineMovePrev<CR>', { noremap = true, silent = false })
  vim.keymap.set('n', '<leader>b', ':BufferLinePick<CR>', { noremap = true, silent = true })

  vim.keymap.set('n', '<leader>D', ':BufferLineCloseRight<CR>', { noremap = true, silent = false })
  vim.keymap.set('n', '<leader>d', ':BufferLinePickClose<CR>', { noremap = true, silent = false })
end
