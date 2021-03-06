local focus = load('focus')
if not focus then return end

focus.setup {
  enable = true,
  autoresize = true,
  excluded_filetypes = { 'fterm', 'term', 'toggleterm', 'harpoon' },
  cursorline = false,
  signcolumn = false,
  width = 110,
  minwidth = 38,
}
