local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
config.default_prog = is_windows and { "powershell.exe" } or { "zsh" }

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16

config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"
config.color_scheme = 'Tokyo Night Storm'

config.window_background_opacity = 0.75
config.macos_window_background_blur = 15

-- Keybindings
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
    -- New tab
    { key = "t", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },

    -- Split pane vertically
    { key = "|", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    -- Split pane horizontally
    { key = "-", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },

    -- Navigate between panes
    { key = "h", mods = "CTRL",   action = wezterm.action { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "CTRL",   action = wezterm.action { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "CTRL",   action = wezterm.action { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "CTRL",   action = wezterm.action { ActivatePaneDirection = "Right" } },

    -- Close current pane
    { key = "x", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
}

return config
