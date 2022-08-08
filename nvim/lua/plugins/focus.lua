local focus = load('focus')
if not focus then return end

focus.setup {
  enable = true,
  autoresize = true,
  excluded_filetypes = {
    '',
    'fterm',
    'term',
    'toggleterm',
    'harpoon',
    'harpoon-menu',
    'NvimTree',
    'TelescopePrompt',
  },
  excluded_buftypes = {
    'prompt',
    'popup',
  },
  cursorline = false,
  signcolumn = false,
  width = 120,
  treewidth = 40,
  minwidth = 38,
}
