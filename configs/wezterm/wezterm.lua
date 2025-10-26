local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
config.skip_close_confirmation_for_processes_named = {
  "nvim",
  "zsh",
}

require('color').apply(config)
require('keymaps').apply(config)
require('appearance').apply(config)
require('tab').apply(config)

return config
