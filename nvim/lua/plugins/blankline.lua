local indent_blankline = load('indent_blankline')
if not indent_blankline then return end

local symbols = {
  '▏',
  '⏐',
  '┊',
  '¦',
}

indent_blankline.setup {
  enabled = true,
  show_first_indent_level = false,
  show_current_context = true,
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "norg",
    "md"
  },
  char = symbols[1],
  context_char = symbols[1],
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_current_context_start = false,
}
