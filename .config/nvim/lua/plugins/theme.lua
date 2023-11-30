return {
  {
    'catppuccin/nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      term_colors = true,
    },
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme "tokyonight"
    end,
  },
}
