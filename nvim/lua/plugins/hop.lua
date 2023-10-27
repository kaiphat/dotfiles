return {
  'phaazon/hop.nvim',
  branch = 'v2',
  config = function()
    local hop = require 'hop'

    hop.setup {
      keys = 'jkdfaslhpioqwertyuzxcvbnm',
      case_insensitive = false,
      -- uppercase_labels = true,
    }

    map('n', 's', function()
      hop.hint_char1 {}
    end)
  end,
}
