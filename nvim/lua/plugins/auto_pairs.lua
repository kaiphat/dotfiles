local autopairs = load('nvim-autopairs')
if not autopairs then return end

autopairs.setup({
  check_ts = true,
  enable_check_bracket_line = false,
  disable_filetype = { "TelescopePrompt" }
})


