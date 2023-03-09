return {
  'tzachar/local-highlight.nvim',
  config = function()
    local hl = require 'local-highlight'

    hl.setup {
      hlgroup = 'LspReferenceText',
      cw_hlgroup = 'LspReferenceText',
    }
  end,
}
