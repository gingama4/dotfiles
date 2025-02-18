return {
  name = "folke/snacks.nvim",
  dir = "@snacks_nvim@",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { fps = 120 },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = "󰙅 ", key = "e", desc = "Explorer", action = "<leader>fe" },
          { icon = " ", key = "f", desc = "Find Files", action = ":Telescope find_files<CR>" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    explorer = { enabled = true, replace_netrw = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    vim.keymap.set("n", "<leader>fe",
      function() require("snacks").explorer() end,
      { noremap = true, silent = true })
  end,
}

