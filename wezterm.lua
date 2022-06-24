local wezterm = require 'wezterm';

local colors = {
  foreground = "silver",
  background = "black",
  cursor_bg = "#52ad70",
  cursor_fg = "black",
  cursor_border = "#52ad70",
  selection_fg = "black",
  selection_bg = "#fffacd",
  scrollbar_thumb = "#222222",
  ansi = {"black", "maroon", "green", "olive", "navy", "purple", "teal", "silver"},
  brights = {"grey", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},
  compose_cursor = "orange",
}

return {
  font_size = 10.4,
  -- font = wezterm.font("JetBrains Mono Medium Nerd Font Complete"),
  font = wezterm.font("VictorMono-Bold")
}
