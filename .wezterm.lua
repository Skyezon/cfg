local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16

config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"
config.color_scheme = 'Tokyo Night Storm'

config.window_background_opacity = 0.75
config.macos_window_background_blur = 15

return config
