local M = {}

M.set_mappings = function()
  local flash = require 'flash'

  map({ 'n', 'x', 'o' }, 's', function()
    flash.jump {}
  end)
end

return {
  'folke/flash.nvim',
  config = function()
    local flash = require 'flash'

    M.set_mappings()

    flash.setup {
      labels = 'jkdfaslhpioqwertyuzxcvbnm',

      label = {
        reuse = 'none',
      },

      char = {
        keys = { 'f', 'F', 't', 'T', ';' },
      },

      prompt = {
        enabled = false,
      },
    }
  end,
}
