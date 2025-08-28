local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.automatically_reload_config = true

config.color_scheme = "Kanagawa (Gogh)"

config.font_size = 14.0
config.window_frame = {
	font_size = 12.0,
}
config.font = wezterm.font_with_fallback({
	{ family = "HackGen Console NF", weight = "Regular" },
	{ family = "HackGen Console NF", weight = "Regular", assume_emoji_presentation = true },
})

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.use_ime = true

config.check_for_updates = false
config.front_end = "WebGpu"

return config
