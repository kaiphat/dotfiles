return {
  'shortcuts/no-neck-pain.nvim',
  config = function()

    local nnp = require 'no-neck-pain'

    nnp.setup {
      enableOnVimEnter = false,

      width = 105,

      buffers = {
        backgroundColor = nil,

        bo = {
          filetype = 'norg',
        }
      },

   }

  end
}
