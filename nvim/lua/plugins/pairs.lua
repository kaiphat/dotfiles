return {
  'echasnovski/mini.pairs',
  config = function()
    local pairs = require 'mini.pairs'

    pairs.setup {
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%)a-zA-Z]' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%]a-zA-Z]' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%}a-zA-Z]' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = {
          action = 'closeopen',
          pair = '""',
          neigh_pattern = '[^\\][^a-zA-Z]',
          register = { cr = false },
        },
        ['\''] = {
          action = 'closeopen',
          pair = '\'\'',
          neigh_pattern = '[^%a\\][^a-zA-Z]',
          register = { cr = false },
        },
        ['`'] = {
          action = 'closeopen',
          pair = '``',
          neigh_pattern = '[^\\][^a-zA-Z]',
          register = { cr = false },
        },
      },
    }
  end,
}
