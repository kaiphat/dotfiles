local windows = load('windows')
if not windows then return end

windows.setup {
  autowidth = {
    enable = true,
    winwidth = 20,
    winminwidth = 10,
    filetype = {
      help = 2,
    },
  },
  ignore = {
    buftype = { "quickfix" },
    filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
  },
}
