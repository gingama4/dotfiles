return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = "󰙅 ", key = "e", desc = "Explorer", action = "<leader>fe" },
            { icon = " ", key = "f", desc = "Find Files", action = ":Telescope find_files<CR>" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
