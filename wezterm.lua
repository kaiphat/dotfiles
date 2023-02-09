local wezterm = require 'wezterm'

-- FONTS --

local get_font_params = function(name, params)
  local names = {
    name,
    {
      family = 'Symbols Nerd Font Mono',
      scale = 0.6,
    },
  }

  return wezterm.font_with_fallback(names, params)
end

local function get_font_rules(name, params)
  local names = {
    name,
    {
      family = 'Symbols Nerd Font Mono',
      scale = 0.65,
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
    font_size = 9.4,
    cell_width = 0.87,
    line_height = 0.89,
    font = get_font_params 'JetBrainsMono Nerd Font',
    font_rules = get_font_rules('JetBrainsMono Nerd Font', { weight = weights.M }),
  },
  iosevka = {
    font_size = 10.5,
    line_height = 0.9,
    cell_width = 1,
    font = get_font_params 'Iosevka SS12',
    font_rules = get_font_rules('Iosevka SS12', { italic = false, weight = weights.B }),
  },
  victor_mono = {
    font_size = 10,
    line_height = 0.80,
    font = get_font_params 'VictorMono',
    font_rules = get_font_rules('VictorMono', { italic = false }),
  },
  caskaydia = {
    font_size = 10,
    line_height = 0.94,
    cell_width = 0.83,
    font = wezterm.font 'CaskaydiaCovePL Nerd Font',
    font_rules = {
      {
        italic = true,
        font = wezterm.font('CaskaydiaCovePL Nerd Font', { italic = false, weight = 'Regular' }),
      },
      {
        intensity = 'Bold',
        font = wezterm.font('CaskaydiaCovePL Nerd Font', { italic = false, weight = 'Regular' }),
      },
      {
        font = wezterm.font('CaskaydiaCovePL Nerd Font', { italic = false, weight = 'Regular' }),
      },
    },
  },
  mononoki = {
    font_size = 10,
    cell_width = 0.83,
    line_height = 0.98,
    font = get_font_params 'mononoki Nerd Font',
    font_rules = get_font_rules('mononoki Nerd Font', { italic = false, weight = weights.B }),
  },
  fira = {
    font_size = 9.3,
    line_height = 0.9,
    cell_width = 0.83,
    font = get_font_params 'FiraCode Nerd Font',
    font_rules = get_font_rules('FiraCode Nerd Font', { italic = false, weight = weights.B }),
  },
  hack = {
    font_size = 10,
    line_height = 1,
    cell_width = 0.8,
    font = get_font_params 'Hack Nerd Font',
    font_rules = get_font_rules('Hack Nerd Font', { italic = false, weight = weights.R }),
  },
}).iosevka

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
  foreground = '#787C99',
  background = '#202837',
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
