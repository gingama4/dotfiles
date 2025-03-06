-- Term Key-Mapping
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  name = "snacks.nvim",
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
    picker = {
      enabled = true,
      win = {
        list = {
          keys = {
            ["s"] = "edit_vsplit",
            ["v"] = "edit_split",
          },
        },
      },
    },
    terminal = {
      enabled = true,
      win = {
        keys = {
          nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
          nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
          nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
          nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
        },
      },
    },
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
