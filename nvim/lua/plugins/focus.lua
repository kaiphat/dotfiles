require("focus").setup {
  enable = true,
  autoresize = true,
  excluded_filetypes = {
    'TelescopePrompt'
  },
  excluded_buftypes = {
    'Telescope',
    'TelescopePrompt'
  },
  cursorline = false,
  signcolumn = false,
  width = 125,
  minwidth = 40
}
