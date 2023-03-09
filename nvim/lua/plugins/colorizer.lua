return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    local colorizer = require 'colorizer'

    colorizer.setup {
      '*',
      '!Lazy',
      '!Notify',
    }
  end,
}
