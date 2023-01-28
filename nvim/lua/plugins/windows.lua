return {
  'anuvyklack/windows.nvim',
  dependencies = {
    'anuvyklack/middleclass',
  },
  config = function()
    local windows = require 'windows'

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
        buftype = { 'quickfix' },
        filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' }
      },
    }
  end
}
