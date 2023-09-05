local M = {}

M.excluded_filetypes = {
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
  'markdown',
  'lazy',
  'noice',
}

M.chars = {
  '▏',
  '│',
  '⏐',
  '┊',
  '¦',
}

M.get_char = function()
  return M.chars[1]
end

return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,
  config = function()
    local ibl = require 'indent_blankline'

    ibl.setup {
      enabled = true,
      show_first_indent_level = false,
      show_current_context = true,
      filetype_exclude = M.excluded_filetypes,
      char = M.get_char(),
      context_char = M.get_char(),
      buftype_exclude = { 'terminal' },
      show_trailing_blankline_indent = false,
      show_current_context_start = false,
    }
  end,
}
