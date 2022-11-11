local autopairs = load('nvim-autopairs')
if not autopairs then return end

autopairs.setup {
  fast_wrap = {
    map = '<M-w>',
    end_key = '.',
  },
  check_ts = true,
  enable_check_bracket_line = true,
  disable_filetype = { "TelescopePrompt" },
  map_c_h = true,
  map_c_w = true,
  ignored_next_char = "[%w%.%(%[%{%<]",
}
