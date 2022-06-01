local feline = load('feline')
if not feline then return end

local getTime = function()
  return os.date('%H:%M:%S')
end

local getPosition = function()
  local current_line = vim.fn.line(".")
  local total_line = vim.fn.line("$")

  if current_line < 10 then
    current_line = '00' .. current_line
  elseif current_line < 100 and current_line > 9 then
    current_line = '0' .. current_line
  end

  if total_line < 10 then
    total_line = '00' .. total_line
  elseif total_line < 100 and total_line > 9 then
    total_line = '0' .. total_line
  end

  return current_line..':'..total_line
end

local colors = {
  dark_blue  = '#404060',
  cyan       = '#a3b8ef',
  light_blue = '#9398cf',
  green      = '#7eca9c',
  yellow     = '#EBCB8B',
  red        = '#e06c75',
  pink       = '#ff75a0',
}

local active_components = {}
local inactive_components = {}

table.insert(active_components, {
  {
    icon = '',
    provider = {
      name = 'file_info',
      opts = {
        type = 'relative'
      }
    },
    hl = {
      fg = colors.dark_blue,
      bg = colors.cyan
    },
    left_sep = {
      str = ' ',
      hl = {
        bg = colors.cyan,
      }
    },
    right_sep = {
      {
        str = ' ',
        hl = {
          bg = colors.cyan,
        },
      },
      {
        str = 'right_filled',
        hl = {
          fg = colors.cyan,
          bg = colors.dark_blue,
        }
      }
    }
  }, 

  {
    icon = '+',
    provider = 'git_diff_added',
    hl = {
      fg = colors.green
    },
    left_sep = ' ',
  },

  {
    icon = '~',
    provider = 'git_diff_changed',
    hl = {
      fg = colors.yellow
    },
    left_sep = ' ',
  },

  {
    icon = '-',
    provider = 'git_diff_removed',
    hl = {
      fg = colors.red
    },
    left_sep = ' ',
  },

  {
    icon = '✗',
    provider = 'diagnostic_errors',
    hl = {
      fg = colors.pink
    },
    left_sep = ' ',
  }
})

table.insert(active_components, {})

table.insert(active_components, {
  {
    icon = ' ',
    provider = 'git_branch',
    hl = {
      fg = colors.yellow,
    },
    right_sep = ' ',
    left_sep = ' ',
  },

  {
    icon = ' ',
    provider = getPosition,
    hl = {
      fg = colors.dark_blue,
      bg = colors.light_blue
    },
    right_sep = {
      str = ' ',
      hl = {
        bg = colors.light_blue
      }
    },
    left_sep = {
      {
        str = 'left_filled',
        hl = {
          fg = colors.light_blue,
          bg = colors.dark_blue
        }
      },
      {
        str = ' ',
        hl = {
          bg = colors.light_blue
        }
      },
    }
  },

  -- {
  --   icon = '',
  --   provider = getTime,
  --   hl = {
  --     fg = colors.dark_blue,
  --     bg = colors.cyan
  --   },
  --   right_sep = {
  --     str = ' ',
  --     hl = {
  --       bg = colors.cyan
  --     }
  --   },
  --   left_sep = {
  --     {
  --       str = 'left_filled',
  --       hl = {
  --         fg = colors.cyan,
  --         bg = colors.light_blue
  --       }
  --     },
  --     {
  --       str = ' ',
  --       hl = {
  --         bg = colors.cyan
  --       }
  --     },
  --   }
  -- }
})


table.insert(inactive_components, {
  {
    icon = '',
    provider = {
      name = 'file_info',
      opts = {
        type = 'relative'
      }
    },
    hl = {
      fg = colors.cyan,
    },
    left_sep = ' ', 
  }, 
})

feline.setup {
  theme = {
    bg = colors.dark_blue
  },
  disable = {
    filetypes = {
      'NvimTree',
      'packer',
      'Telescope'
    },
  },
  components = {
    active = active_components,
    inactive = inactive_components,
  }
}

