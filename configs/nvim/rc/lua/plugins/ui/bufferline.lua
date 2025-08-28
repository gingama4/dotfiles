return {
  name = "bufferline.nvim",
  dir = "@bufferline_nvim@",
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
  },
  opts = {
    options = {
      close_command = function(n)
        Snacks.bufdelete(n)
      end,
      right_mouse_command = function(n)
        Snacks.bufdelete(n)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      separator_style = { " ", "" },
      indicator = {
        style = "underline",
      },
      diagnostics_indicator = function(_, _, diag)
        local icons = GinVim.icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "snacks_layout_box",
        },
      },
      ---@module "bufferline"
      ---@param opts bufferline.IconFetcherOpts
      get_element_icon = function(opts)
        return GinVim.icons.ft[opts.filetype]
      end,
    },
  },
}
