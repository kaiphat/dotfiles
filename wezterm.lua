local wezterm = require 'wezterm'

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   UTILS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local merge = function(...)
  local args = { ... }
  local result = {}

  for _, t in ipairs(args) do
    for key, value in pairs(t) do
      result[key] = value
    end
  end

  return result
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   FONTS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local weights = {
  L = 'Light',
  R = 'Regular',
  B = 'Bold',
  SB = 'DemiBold',
  EB = 'ExtraBold',
  M = 'Medium',
}

local function build_font_params(name, with_italic, weight, params)
  local scale = 0.8
  local font = wezterm.font_with_fallback {
    { family = name, weight = weight },
    { family = 'JetBrains Mono', scale = scale },
    { family = 'Symbols Nerd Font Mono', scale = scale },
    { family = 'Noto Color Emoji', scale = scale },
  }

  return merge(params, {
    font = font,
    font_rules = {
      {
        italic = true,
        font = wezterm.font(name, { italic = with_italic, weight = weight }),
      },
      {
        font = font,
      },
    },
  })
end

local font_config = ({
  jet_brains = build_font_params('JetBrains Mono', true, weights.M, {
    font_size = 8.8,
    cell_width = 1,
    line_height = 1.15,
  }),
  mononoki = build_font_params('mononoki Nerd Font', true, weights.B, {
    font_size = 10,
    cell_width = 0.8,
    line_height = 1.3,
  }),
  agave = build_font_params('agave Nerd Font', false, weights.R, {
    font_size = 11,
    cell_width = 0.8,
    line_height = 1.25,
  }),
  victor = build_font_params('VictorMono Nerd Font', false, weights.SB, {
    font_size = 11,
    cell_width = 1,
    line_height = 0.9,
  }),
  iosevka = build_font_params('Iosevka Term', false, weights.M, {
    font_size = 10,
    cell_width = 1,
    line_height = 1.1,
  }),
  iosevka_ss08 = build_font_params('Iosevka SS08', true, weights.SB, {
    font_size = 9.5,
    cell_width = 1,
    line_height = 1.1,
  }),
  caskaydia = build_font_params('Cascadia Code', true, weights.M, {
    font_size = 8.7,
    cell_width = 1,
    line_height = 1.3,
  }),
  fant = build_font_params('Fantasque Sans Mono', false, weights.R, {
    font_size = 10,
    cell_width = 1,
    line_height = 1.25,
  }),
  roboto = build_font_params('Roboto Mono', true, weights.M, {
    font_size = 9,
    cell_width = 1,
    line_height = 1.1,
  }),
  fira = build_font_params('Fira Code', false, weights.R, {
    font_size = 8.5,
    cell_width = 1,
    line_height = 1.25,
  }),
}).fant

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   THEME   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local dark_colors = {
  foreground = '#787C99',
  background = '#202837',
  cursor_bg = '#ffcc66',
  cursor_border = '#c6d0f5',
  cursor_fg = '#404060',
  selection_fg = '#333355',
  selection_bg = '#787c99',
  scrollbar_thumb = '#222222',
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

local light_colors = {
  foreground = '#787C99',
  background = '#ffffff',
  cursor_bg = '#F7768E',
  cursor_border = '#F7768E',
  cursor_fg = '#404060',
  selection_fg = '#333355',
  selection_bg = '#787c99',
  scrollbar_thumb = '#222222',
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

local function get_colors()
  if os.getenv 'DARK_THEME' == '1' then
    return dark_colors
  else
    return light_colors
  end
end

local paddings = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   RESULT   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local config = {
  front_end = 'WebGpu',
  colors = get_colors(),
  window_padding = paddings,
  enable_tab_bar = false,
  enable_scroll_bar = false,
  scrollback_lines = 10000,
  cursor_blink_rate = 1000,
  max_fps = 100,
  animation_fps = 100,
  window_background_opacity = 0.87,
  default_cursor_style = 'BlinkingBlock',
  warn_about_missing_glyphs = false,
  use_cap_height_to_scale_fallback_fonts = true,
  disable_default_key_bindings = true,
  adjust_window_size_when_changing_font_size = false,

  keys = {
    {
      key = 'C',
      mods = 'CTRL',
      action = wezterm.action.CopyTo 'Clipboard',
    },
    {
      key = 'V',
      mods = 'CTRL',
      action = wezterm.action.PasteFrom 'Clipboard',
    },
    {
      key = '=',
      mods = 'CTRL',
      action = wezterm.action.IncreaseFontSize,
    },
    {
      key = '-',
      mods = 'CTRL',
      action = wezterm.action.DecreaseFontSize,
    },
  },
}

return merge(config, font_config)
