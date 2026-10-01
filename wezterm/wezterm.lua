local wezterm = require("wezterm")
local config = {}

config.default_prog = { "powershell.exe", "-NoLogo" }

config.color_scheme = "tokyonight_night"

config.font = wezterm.font("BlexMono Nerd Font Mono")
config.font_size = 12.0

config.colors = {
  cursor_bg = "#7aa2f7",
  cursor_border = "#7aa2f7",
}

return config