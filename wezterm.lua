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
  R = 'Regular',
  B = 'Bold',
  SB = 'DemiBold',
  EB = 'ExtraBold',
  M = 'Medium',
}

local function build_font_params(name, with_italic, weight, params)
  local font = wezterm.font_with_fallback {
    { family = name, weight = weight },
    { family = 'JetBrainsMono Nerd Font' },
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
  jet_brains = build_font_params('JetBrainsMono Nerd Font', true, weights.B, {
    font_size = 9.4,
    cell_width = 0.8,
    line_height = 1,
  }),
  mononoki = build_font_params('mononoki Nerd Font', true, weights.B, {
    font_size = 11,
    cell_width = 0.8,
    line_height = 1.1,
  }),
  victor = build_font_params('VictorMono Nerd Font', true, weights.B, {
    font_size = 10.3,
    cell_width = 1,
    line_height = 1,
  }),
  iosevka_ss12 = build_font_params('Iosevka SS12', true, weights.EB, {
    font_size = 10.4,
    cell_width = 1,
    line_height = 1.1,
  }),
  iosevka = build_font_params('Iosevka Nerd Font', true, weights.EB, {
    font_size = 10.4,
    cell_width = 1,
    line_height = 1.1,
  }),
  fira = build_font_params('FiraCode Nerd Font', false, weights.B, {
    font_size = 9.8,
    cell_width = 0.8,
    line_height = 1,
  }),
  caskaydia = build_font_params('CaskaydiaCove Nerd Font Mono', true, weights.B, {
    font_size = 10.3,
    cell_width = 0.8,
    line_height = 1.1,
  }),
}).victor

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

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   RESULT   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local config = {
  colors = colors,
  window_padding = padding,
  enable_tab_bar = false,
  scrollback_lines = 10000,
  cursor_blink_rate = 750,
  max_fps = 60,
  animation_fps = 60,
  window_background_opacity = 0.94,
  default_cursor_style = 'BlinkingBlock',
  warn_about_missing_glyphs = false,
  use_cap_height_to_scale_fallback_fonts = true,
  disable_default_key_bindings = true,
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
