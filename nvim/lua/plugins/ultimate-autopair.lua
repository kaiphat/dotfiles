return {
  'altermo/ultimate-autopair.nvim',
  enabled = true,
  branch = 'v0.6',
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local p = require 'ultimate-autopair'

    p.setup {}
  end,
}
