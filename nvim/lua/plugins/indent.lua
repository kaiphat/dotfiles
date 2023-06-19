local chars = {
  '▏',
  '│',
  '⏐',
  '┊',
  '¦',
}

return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,
  config = function()
    local ib = require 'indent_blankline'

    ib.setup {
      enabled = true,
      show_first_indent_level = false,
      show_current_context = true,
      filetype_exclude = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
        'norg',
        'md',
        'mason',
      },
      char = chars[1],
      context_char = chars[1],
      buftype_exclude = { 'terminal' },
      show_trailing_blankline_indent = false,
      show_current_context_start = false,
    }
  end,
}
