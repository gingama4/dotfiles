local status, bufferline = pcall(require, 'bufferline')

if (not status) then return end

vim.opt.termguicolors = true
bufferline.setup({
  options = {
    numbers = function(opts)
      return string.format("%s.%s", opts.ordinal, opts.lower(opts.id))
    end,
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,
    --custom_filter = function(buf_number)
    --  if vim.bo[buf_number].filetype === 'qf' then
    --    return false
    --  end
    --  if vim.bo[buf_number].buftype === 'terminal' then
    --    return false
    --  end
    --  if vim.fn.bufname(buf_number) == '' or vim.fn.bufname(buf_number) == '[No Name]' then
    --    return false
    --  end
    --  if vim.fn.bufname(buf_number) == '[dap-repl]' then
    --    return false
    --  end

    --  return true
    --end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    enforce_regular_tabs = true,
    sort_by = 'insert_after_current',
  },
})

vim.keymap.set('n', '<Leader>b', '<cmd>BufferLinePick<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '@', '<cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '#', '<cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true })

