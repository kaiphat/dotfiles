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
  jet_brains = build_font_params('JetBrainsMono Nerd Font', false, weights.B, {
    font_size = 9,
    cell_width = 1,
    line_height = 1.25,
  }),
  mononoki = build_font_params('mononoki Nerd Font', false, weights.B, {
    font_size = 10.4,
    cell_width = 0.8,
    line_height = 1.25,
  }),
  agave = build_font_params('agave Nerd Font', false, weights.R, {
    font_size = 12.3,
    cell_width = 0.8,
    line_height = 1.25,
  }),
  victor = build_font_params('VictorMono Nerd Font', false, weights.B, {
    font_size = 10,
    cell_width = 1,
    line_height = 1,
  }),
  iosevka = build_font_params('Iosevka Term', false, weights.EB, {
    font_size = 9.9,
    cell_width = 1,
    line_height = 1.2,
  }),
  iosevka_custom = build_font_params('Iosevka Custom', false, weights.B, {
    font_size = 9.9,
    cell_width = 1,
    line_height = 1.15,
  }),
  caskaydia = build_font_params('CaskaydiaCove Nerd Font Mono', false, weights.R, {
    font_size = 10,
    cell_width = 0.8,
    line_height = 1.25,
  }),
}).agave

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   EVENTS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   THEME   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local dark_colors = {
  foreground = '#787C99',
  background = '#202837',
  cursor_bg = '#c6d0f5',
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

local colors
if os.getenv 'DARK_THEME' == '1' then
  colors = dark_colors
else
  colors = light_colors
end

local padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   RESULT   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local config = {
  colors = colors,
  window_padding = padding,
  enable_tab_bar = false,
  scrollback_lines = 10000,
  cursor_blink_rate = 750,
  max_fps = 100,
  animation_fps = 100,
  window_background_opacity = 0.95,
  default_cursor_style = 'BlinkingBlock',
  warn_about_missing_glyphs = false,
  use_cap_height_to_scale_fallback_fonts = false,
  disable_default_key_bindings = true,
  freetype_load_target = 'HorizontalLcd',
  freetype_render_target = 'HorizontalLcd',
  adjust_window_size_when_changing_font_size = true,
  allow_square_glyphs_to_overflow_width = 'Always',
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
  },
}

return merge(config, font_config)
