local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

local leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

local keys = {
  { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
  { key = 's', mods = 'SHIFT|CTRL', action = act.PaneSelect },
  -- Command Palette
  { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
}

local key_tables = {}

local mouse_bindings = {}

function M.apply(config)
  config.leader = leader
  config.keys = keys
  config.key_tables = key_tables
  config.mouse_bindings = mouse_bindings
end

return M
