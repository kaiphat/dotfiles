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
    -- font_size = 9.6,
    font_size = 10.2,
    font = wezterm.font('JetBrainsMono Nerd Font'),
    font_rules = {
      {
        italic = true,
        font = font('JetBrainsMono Nerd Font', { italic = true, weight = 'Medium' }),
      },
      {
        intensity = 'Bold',
        font = font('JetBrainsMono Nerd Font', { weight = 'Medium' }),
      },
      {
        font = font('JetBrainsMono Nerd Font', { weight = 'Medium' }),
      },
    },
    line_height = 1.19,
  },
  iosevka = {
    font_size = 11,
    font = wezterm.font('Iosevka Nerd Font'),
    line_height = 1.14,
    font_rules = {
      {
        font = font('Iosevka Nerd Font', { italic = false, weight = 'Medium' })
      }
    }
  },
  victor_mono = {
    font_size = 10.4,
    font = font('VictorMono'),
    line_height = 1.24,
    font_rules = {
      {
        font = font('VictorMono', { italic = false })
      }
    }
  },
  caskaydia = {
    font_size = 10.4,
    font = font('CaskaydiaCovePL Nerd Font'),
    line_height = 1.3,
    font_rules = {
      {
        font = font('CaskaydiaCovePL Nerd Font', { italic = false, weight = 'Regular' })
      }
    }
  },
  mononoki = {
    font_size = 10.9,
    font = font 'mononoki Nerd Font',
    line_height = 1.23,
    font_rules = {
      {
        font = font('mononoki Nerd Font', { italic = false, weight = 'Medium' })
      }
    }
  },
  fira = {
    font_size = 10,
    font = font 'FiraCode Nerd Font',
    line_height = 1.37,
    font_rules = {
      {
        font = font('FiraCode Nerd Font', { italic = false, weight = 'Medium' })
      }
    }
  },
}).jet_brains

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
  dpi = 192,
  enable_wayland = true,
  window_background_opacity = 1.0
}

return merge {
  config,
  font_config,
}
