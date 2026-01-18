local wezterm = require("wezterm")
local M = {}

local appearance = {
  -- background
  window_background_opacity = 0.7,
  macos_window_background_blur = 13,

  -- font
  font_size = 14.0,
  font = wezterm.font("HackGen Console NF"),
  unicode_version = 14,

  -- window title
  window_decorations = "RESIZE",
  window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 0,
  },
  window_close_confirmation = "NeverPrompt",

  -- Tab
  show_tabs_in_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  show_new_tab_button_in_tab_bar = false,
  show_close_tab_button_in_tabs = false,
  tab_max_width = 30,
  use_fancy_tab_bar = false,
  colors = {
    tab_bar = {
      background = "none",
      inactive_tab_edge = "none",
    },
    cursor_bg = "#ffcc00",
    cursor_fg = "#000000",
    cursor_border = "#ffaa00",
  },
}

function M.apply(config)
  for k, v in pairs(appearance) do
    config[k] = v
  end
end

return M
