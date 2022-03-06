require('indent_blankline').setup {
  enabled = false,
  show_current_context = true,
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
  },
  char = "▏",
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_current_context_start = false,
  context_patterns = { 'class', 'function', 'method', 'object', 'for', 'if', 'else', 'while', 'array', 'try', 'catch', 'html'}
}
