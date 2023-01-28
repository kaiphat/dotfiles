return {
  'phaazon/hop.nvim',
  branch = 'v2',
  config = function()

    local hop = require 'hop'

    hop.setup {
      keys = 'jfkdls;aieowpqQFPDLS:AIEOWKJ',
      case_insensitive = false,
      -- uppercase_labels = true,
    }

    map('n', '<leader>i', function()
      hop.hint_char1 {}
    end)

  end
}
