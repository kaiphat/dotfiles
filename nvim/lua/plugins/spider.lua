return {
  'chrisgrieser/nvim-spider',
  config = function()
    local s = require 'spider'

    map({ 'n', 'o', 'x' }, 'w', function()
      s.motion 'w'
    end)
    map({ 'n', 'o', 'x' }, 'e', function()
      s.motion 'e'
    end)
    map({ 'n', 'o', 'x' }, 'b', function()
      s.motion 'b'
    end)
  end,
}
