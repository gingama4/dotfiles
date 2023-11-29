return function(_, opts)
  local bufferline = require 'bufferline'
  bufferline.setup(opts)

  -- Overwrite default tab move keymap
  vim.keymap.set('n', 'gt', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', 'gT', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

  vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', ']b', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '[b', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>b', ':BufferLinePick<CR>', { noremap = true, silent = true })

  vim.keymap.set('n', '<leader>wl', ':BufferLineCloseRight<CR>', { noremap = true, silent = false })
  vim.keymap.set('n', '<leader>wh', ':BufferLineCloseLeft<CR>', { noremap = true, silent = false })
  vim.keymap.set('n', '<leader>wb', ':BufferLineCloseOthers<CR>', { noremap = true, silent = false })
  vim.keymap.set('n', '<leader>we', ':BufferLinePickClose<CR>', { noremap = true, silent = false })
end
