local M = {}

M.chars = {
  '▏',
  '│',
  '⏐',
  '┊',
  '¦',
}

return {
  {
    'echasnovski/mini.align',
    config = function()
      local align = require 'mini.align'

      align.setup {}
    end,
  },

  {
    'echasnovski/mini.splitjoin',
    config = function()
      local m = require 'mini.splitjoin'

      m.setup {}
    end,
  },

  {
    'echasnovski/mini.surround',
    config = function()
      local m = require 'mini.surround'

      local key = '<leader>'
      m.setup {
        mappings = {
          add = key .. 'sa',
          delete = key .. 'sd',
          find = key .. 'sf',
          find_left = key .. 'sF',
          highlight = key .. 'sh',
          replace = key .. 'sr',
          update_n_lines = key .. 'sn',
        },
      }
    end,
  },

  {
    'echasnovski/mini.trailspace',
    config = function()
      local trail = require 'mini.trailspace'

      trail.setup {}

      map('n', '<leader>ut', function()
        trail.trim()
      end)
    end,
  },

  {
    'echasnovski/mini.comment',
    config = function()
      local comment = require 'mini.comment'

      comment.setup {
        mappings = {
          comment = 'gc',
          comment_line = 'gcc',
          textobject = 'gc',
        },
      }
    end,
  },

  {
    'echasnovski/mini.indentscope',
    enabled = false,
    config = function()
      local indent = require 'mini.indentscope'

      indent.setup {
        draw = {
          delay = 100,
        },

        mappings = {},

        options = {
          border = 'both',
          indent_at_cursor = true,
          try_as_border = false,
        },

        symbol = M.chars[1],
      }
    end,
  },
}
