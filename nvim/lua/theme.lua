local c = {
  white = "#b5bcc9",
  darker_black = "#10171e",
  black = "#131a21", --  nvim bg
  black2 = "#1a2128",
  one_bg = "#1e252c",
  one_bg2 = "#2a3138",
  one_bg3 = "#363d44",
  grey = "#363d44",
  grey_fg = "#4e555c",
  grey_fg2 = "#51585f",
  light_grey = "#545b62",
  red = "#ef8891",
  baby_pink = "#fca2aa",
  pink = "#fca2af",
  line = "#272e35", -- for lines like vertsplit
  green = "#9fe8c3",
  vibrant_green = "#9ce5c0",
  blue = "#99aee5",
  nord_blue = "#9aa8cf",
  yellow = "#fbdf90",
  sun = "#fbdf9a",
  purple = "#c2a2e3",
  dark_purple = "#b696d7",
  teal = "#92dbb6",
  orange = "#EDA685",
  cyan = "#b5c3ea",
  statusline_bg = "#181f26",
  lightbg = "#222930",
  pmenu_bg = "#ef8891",
  folder_bg = "#99aee5",
}

local pastel_16 = {
  base0A = "#f5d595",
  base04 = "#4f565d",
  base07 = "#b5bcc9",
  base05 = "#ced4df",
  base0E = "#c2a2e3",
  base0D = "#a3b8ef",
  base0C = "#abb9e0",
  base0B = "#9ce5c0",
  base02 = "#31383f",
  base0F = "#e88e9b",
  base03 = "#40474e",
  base08 = "#ef8891",
  base01 = "#2c333a",
  base00 = "#131a21",
  base09 = "#EDA685",
  base06 = "#d3d9e4",
}

local colors = {
  white         = '#abb2bf',
  white         = "#b5bcc9",
  light_white   = '#ceceef',
  red           = '#DE8C92',
  nord_blue     = '#81A1C1',
  sun           = '#EBCB8B',
  cyan2         = '#91b9f1',
  light_blue    = '#9398cf',
  lightest_blue = '#404060',
  bg            = '#2d3139',
  mono_1        = '#787C99',
  mono_3        = '#5c6370',
  theme_7       = '#43d08a',
  theme_9       = '#282c34',
  theme_13      = '#2c323c',
  line          = '#40474e',
  pink          = '#ff75a0',
  p             = '#c96090',
  green         = '#7eca9c',
  green2        = '#4ea0bc',
  nord_blue     = '#81A1C1',
  blue          = '#61afef',
  sun           = '#EBCB8B',
  teal          = '#519ABA',
  orange        = '#fca2aa',
  orange2       = '#e79382',
  cyan          = '#a3b8ef',
  cyan_2        = '#bcddee',
  light_blue    = '#9398cf',
  purple        = "#c2a2e3",
  dark_purple   = "#b696d7",
  dark_purple   = "#b892c7",
  lightest_blue = '#404060',
  brackets      = '#757595',
  a             = '#536162',

  red         = '#e06c75',
  red         = "#ef8891",
  green       = '#56b6c2',
  green       = '#7eca9c',
  g2          = '#66A5AD',
  gray        = '#6e88a6',
  brown       = '#c8ae9d',
  select      = '#fbdf9a',
  nordGray1   = '#4c566a',
  nordGray2   = '#3b4252',
  nordWhite   = '#d8dee9',
  tokyoYellow = '#ffcc66',

  prettyGray  = '#2b2f3a',
  prettyWhite = '#dae0ee',
  prettyRed   = '#fca2af',
  greenTea    = '#9CC4B2',

  dark      = '#202837',
  dark_gray = '#788aa3'
}

local hl = function(list)
  for group, opt in pairs(list) do
    local new_opts = {}
    local inheritance_opts = {}

    for key, value in pairs(opt) do
      if is_number(key) then
        local highlights = vim.api.nvim_get_hl_by_name(value, true)

        for option, color in pairs(highlights) do

          local match_type = {
            background = 'bg',
            foreground = 'fg'
          }

          local matched_type = match_type[option]
          if (matched_type) then
            inheritance_opts[matched_type] = color or 'NONE'
          else
            inheritance_opts[option] = color or 'NONE'
          end
        end
      else
        new_opts[key] = value or 'NONE'
      end
    end

    vim.api.nvim_set_hl(0, group, merge_tables(inheritance_opts, new_opts))
  end
end

hl {
  It = { italic = true },
  Bold = { bold = true },
  Ul = { underline = true },
  Uc = { undercurl = true },
}

hl {
  Normal = { fg = c.white, bg = c.one_bg2 },
  Visual = { fg = nil, bg = c.grey_fg },
}
