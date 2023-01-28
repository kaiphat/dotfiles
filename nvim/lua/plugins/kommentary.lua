return {
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

  end
}
