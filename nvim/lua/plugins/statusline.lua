local M = {}

M.get_position = function()
  local current_line = vim.fn.line '.'
  local total_line = vim.fn.line '$'

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

  return current_line .. ':' .. total_line
end

M.colors = {
  dark_blue = '#404060',
  cyan = '#a3b8ef',
  light_blue = '#9398cf',
  green = '#7eca9c',
  yellow = '#EBCB8B',
  red = '#e06c75',
  pink = '#ff75a0',
}

M.active_components = {
  {
    {
      icon = '',
      provider = {
        name = 'file_info',
        opts = {
          type = 'relative',
          file_modified_icon = '',
        },
      },
      hl = {
        fg = M.colors.dark_blue,
        bg = M.colors.cyan,
      },
      left_sep = {
        str = ' ',
        hl = {
          bg = M.colors.cyan,
        },
      },
      right_sep = {
        {
          str = ' ',
          hl = {
            bg = M.colors.cyan,
          },
        },
        {
          str = 'right_filled',
          hl = {
            fg = M.colors.cyan,
            -- bg = colors.dark_blue,
          },
        },
      },
    },
    {
      icon = '+',
      provider = 'git_diff_added',
      hl = {
        fg = M.colors.green,
      },
      left_sep = ' ',
    },

    {
      icon = '~',
      provider = 'git_diff_changed',
      hl = {
        fg = M.colors.yellow,
      },
      left_sep = ' ',
    },

    {
      icon = '-',
      provider = 'git_diff_removed',
      hl = {
        fg = M.colors.red,
      },
      left_sep = ' ',
    },

    {
      icon = 'x',
      provider = 'diagnostic_errors',
      hl = {
        fg = M.colors.pink,
      },
      left_sep = ' ',
    },

    -- gap
    {
      provider = function()
        return ' '
      end,
      hl = {
        fg = M.colors.pink,
      },
    },
  },
  {},
  {
    {
      icon = ' ',
      provider = 'git_branch',
      hl = {
        fg = M.colors.yellow,
        bg = M.colors.dark_blue,
      },
      right_sep = {
        {
          str = ' ',
          hl = {
            bg = M.colors.dark_blue,
          },
        },
      },
      left_sep = {
        {
          str = 'left_filled',
          hl = {
            fg = M.colors.dark_blue,
          },
        },
        {
          str = ' ',
          hl = {
            bg = M.colors.dark_blue,
          },
        },
      },
    },

    {
      icon = ' ',
      provider = M.get_position,
      hl = {
        fg = M.colors.dark_blue,
        bg = M.colors.light_blue,
      },
      right_sep = {
        str = ' ',
        hl = {
          bg = M.colors.light_blue,
        },
      },
      left_sep = {
        {
          str = 'left_filled',
          hl = function()
            if require('feline.providers.git').git_info_exists() then
              return {
                bg = M.colors.dark_blue,
                fg = M.colors.light_blue,
              }
            else
              return {
                fg = M.colors.light_blue,
              }
            end
          end,
        },
        {
          str = ' ',
          hl = {
            bg = M.colors.light_blue,
          },
        },
      },
    },
  },
}

M.inactive_components = {
  {
    icon = '',
    provider = {
      name = 'file_info',
      opts = {
        type = 'relative',
      },
    },
    hl = {
      fg = M.colors.cyan,
    },
    left_sep = ' ',
  },
}

return {
  'feline-nvim/feline.nvim',
  config = function()
    local feline = require 'feline'

    feline.setup {
      theme = {
        bg = 'NONE',
      },
      disable = {
        filetypes = {
          'NvimTree',
          'packer',
          'Telescope',
        },
      },
      components = {
        active = M.active_components,
        inactive = M.inactive_components,
      },
    }
  end,
}
