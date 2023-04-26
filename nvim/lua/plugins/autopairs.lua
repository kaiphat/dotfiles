return {
  'windwp/nvim-autopairs',
  config = function()
    local p = require 'nvim-autopairs'

    p.setup {
      check_ts = true,
      enable_check_bracket_line = true,
    }
  end,
}
