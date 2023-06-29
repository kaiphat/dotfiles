return {
  'ThePrimeagen/harpoon',
  config = function()
    local harpoon = require 'harpoon'

    harpoon.setup {
      menu = {
        width = 100
      },

      global_settings = {
        mark_branch = true,
      }
    }

    local ui = require('harpoon.ui')
    local mark = require('harpoon.mark')

    map('n', 'mm', function()
      mark.toggle_file()
    end)
    map('n', "'m", function()
      ui.toggle_quick_menu()
    end)
    map('n', 'mn', function()
      ui.nav_next()
    end)
    map('n', 'mp', function()
      ui.nav_prev()
    end)
    -- map('n', '<Tab>', function()
    --   ui.nav_prev()
    -- end)
    --
    --
  end,
}
