local symbols = {
  '▏',
  '│',
  '⏐',
  '┊',
  '¦',
}

return {
  'echasnovski/mini.indentscope',
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

      symbol = symbols[1],

    }
  end
}
