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
          { icon = "󰙅 ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
          { icon = " ", key = "f", desc = "Find Files", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    explorer = { enabled = true, replace_netrw = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
  },
  keys = {
    -- Explorer
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

    -- Lazygit
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

    -- Notifier
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

    -- Fuzzy Finder
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fp", function() Snacks.picker.pickers() end, desc = "Picker Pickers" },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
