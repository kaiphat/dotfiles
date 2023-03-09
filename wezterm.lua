local wezterm = require 'wezterm'

-- FONTS --

local function get_font_rules(name, params)
  local names = {
    name,
    {
      family = 'Symbols Nerd Font Mono',
      scale = 0.6,
    },
  }

  return {
    {
      font = wezterm.font_with_fallback(names, params),
    },
  }
end

local weights = {
  R = 'Regular',
  B = 'Bold',
  SB = 'DemiBold',
  M = 'Medium',
}

local font_config = ({
  jet_brains = {
    font_size = 10,
    cell_width = 1,
    line_height = 1,
    font = wezterm.font 'JetBrainsMono',
    font_rules = get_font_rules('JetBrains Mono Bold', { weight = weights.R }),
  },
  iosevka = {
    font_size = 10.5,
    line_height = 1,
    cell_width = 1,
    font = wezterm.font 'Iosevka',
    font_rules = get_font_rules('Iosevka SS14', { italic = false, weight = weights.B }),
  },
  victor_mono = {
    font_size = 10,
    line_height = 0.80,
    font = wezterm.font 'VictorMono',
    font_rules = get_font_rules('VictorMono', { italic = false }),
  },
  caskaydia = {
    font_size = 10.6,
    line_height = 1.1,
    cell_width = 1,
    font = wezterm.font 'CaskaydiaCovePL Nerd Font',
    font_rules = get_font_rules('CaskaydiaCovePL Nerd Font', { italic = false, weight = weights.R }),
  },
  mononoki = {
    font_size = 11,
    cell_width = 0.8,
    line_height = 1.1,
    font = wezterm.font 'mononoki Nerd Font',
    font_rules = get_font_rules('mononoki', { italic = false, weight = weights.R }),
  },
  fira = {
    font_size = 10,
    line_height = 1.2,
    cell_width = 1,
    font = wezterm.font 'Fira Code',
    font_rules = get_font_rules('Fira Code', { italic = false, weight = weights.R }),
  },
  hack = {
    font_size = 11,
    line_height = 1,
    cell_width = 1,
    font = wezterm.font 'Hack Nerd Font',
    font_rules = get_font_rules('Hack Nerd Font', { italic = false, weight = weights.R }),
  },
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

local backgrounds = {
  '202837',
  '242939',
  '222831',
}

local colors = {
  foreground = '#787C99',
  background = '#' .. backgrounds[1],
  cursor_bg = '#ffcc66',
  cursor_border = '#ffcc66',
  cursor_fg = '#404060',
  selection_fg = '#333355',
  selection_bg = '#787c99',
  scrollbar_thumb = '#222222',
  compose_cursor = 'orange',
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

local padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- RESULT --

-- local gpus = wezterm.gui.enumerate_gpus()

local config = {
  colors = colors,
  window_padding = padding,
  enable_tab_bar = false,
  scrollback_lines = 10000,
  cursor_blink_rate = 750,
  max_fps = 120,
  animation_fps = 120,
  window_background_opacity = 1,
  enable_kitty_graphics = true,
  default_cursor_style = 'BlinkingBlock',
  warn_about_missing_glyphs = false,
}

return merge {
  config,
  font_config,
}
