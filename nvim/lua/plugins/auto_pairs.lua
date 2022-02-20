local autopairs = require('nvim-autopairs')

autopairs.setup({
  check_ts = true,
  enable_check_bracket_line = false,
  disable_filetype = { "TelescopePrompt" }
})


