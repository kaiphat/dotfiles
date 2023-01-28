return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  config = function()
    local diffview = require 'diffview'

    diffview.setup {
      enhanced_diff_hl = true,
      file_history_panel = {
        win_config = {
          position = 'bottom',
          height = 20,
          win_opts = {}
        },
      }
    }
  end
}
