local indent_blankline = load('indent_blankline')
if not indent_blankline then return end

indent_blankline.setup {
  enabled = true,
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
  char = "▏",
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_current_context_start = false,
  context_patterns = { 'class', 'function', 'method', 'object', 'for', 'if', 'else', 'while', 'array', 'try', 'catch', 'html' }
}
