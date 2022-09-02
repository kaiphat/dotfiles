local wezterm = require 'wezterm'

-- FONTS --

local font = function(name, params)
  local names = {
    name,
    'JetBrainsMono Nerd Font',
  }

  return wezterm.font_with_fallback(names, params)
end

local font_config = ({
  jet_brains = {
    font_size = 10.8,
    -- font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' }),
    font = wezterm.font('JetBrainsMono Nerd Font'),
    line_height = 1.0,
  },
  victor_mono = {
    font_size = 10.4,
    font = font('VictorMono-Bold'),
    line_height = 1.05,
  },
  caskaydia = {
    font_size = 10.8,
    font = font('CaskaydiaCovePL Nerd Font'),
    line_height = 1.1,
  },
  mononoki = {
    font_size = 11.6,
    font = font 'mononoki Nerd Font',
    line_height = 1.1,
    font_rules = {
      {
        italic = true,
        font = font('mononoki Nerd Font', { italic = false })
      }
    }
  }
}).mononoki

-- UTILS --

local merge = function(list)
  local result = list[1]

  for i = 2, #list do
    for key, value in pairs(list[i]) do
      result[key] = value
    end
  end

  return result
end

-- EVENTS --

wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- THEME --

local colors = {
  foreground = "#787C99",
  background = "#202837",
  cursor_bg = "#ffcc66",
  cursor_border = "#ffcc66",
  cursor_fg = "#404060",
  selection_fg = "#333355",
  selection_bg = "#787c99",
  scrollbar_thumb = "#222222",
  compose_cursor = "orange",
  ansi = {
    '#404060',
    '#F7768E',
    '#9CC4B2',
    '#88C0D0',
    '#6e88a6',
    '#9398cf',
    '#c8ae9d',
    '#E5E9F0',
  },
  brights = {
    '#9CC4B2',
    '#F7768E',
    '#9CC4B2',
    '#ffcc66',
    '#6e88a6',
    '#9398cf',
    '#c8ae9d',
    '#ACB0D0',
  },
}

local padding_value = 7
local padding = {
  left = padding_value,
  right = padding_value,
  top = padding_value,
  bottom = 0,
}

-- RESULT --

local config = {
  colors = colors,
  window_padding = padding,
  enable_tab_bar = false,
  scrollback_lines = 10000,
  animation_fps = 60,
  dpi = 192,
  enable_wayland = true,
}

return merge {
  config,
  font_config,
}
