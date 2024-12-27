return {
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          globalstatus = true,
          disabled_filetypes = {
            'neo-tree',
          },
        },
      }
    end,
  },

  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    keys = {
      { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>",  desc = "Delete Buffers to the Left" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",  desc = "Prev Buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<CR>",  desc = "Next Buffer" },
    },
    opts = {
      options = {
        --stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        --stylua: ignore
        righ_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = GinVim.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
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
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return GinVim.config.icons.ft[opts.filetype]
        end,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
