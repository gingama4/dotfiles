return {
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    enabled = true,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = function ()
      return {
        options = {
          globalstatus = true,
          disabled_filetypes = {
            'neo-tree',
          },
        },
      }
    end,
    config = require 'plugins.configs.lualine'
  },
  {
    'akinsho/bufferline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = function()
      return {
        options = {
          indicator = {
            style = 'underline'
          },
          custom_filter = function(buf_number, buf_numbers)
              -- filter out filetypes you don't want to see
              if vim.bo[buf_number].filetype == "terminal" then
                  return false
              end
              -- filter out by buffer name
              if vim.fn.bufname(buf_number) == "" or vim.fn.bufname(buf_number) == '[No Name]' then
                  return false
              end

              return true
          end,
          show_buffer_close_icons = false,
          enforce_regular_tabs = true,
        }
      }
    end,
    config = require 'plugins.configs.bufferline'
  },
}
