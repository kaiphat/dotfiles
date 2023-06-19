local char = '▏'

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  config = function()

    local gitsigns = require 'gitsigns'

    gitsigns.setup {
      signs = {
        add          = { hl = 'GitSignsAdd', text = char, numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = char, numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = char, numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = char, numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = char, numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        untracked    = { hl = 'GitSignsAdd', text = char, numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      },
      signcolumn = false,
      linehl = false,
      numhl = false,
      current_line_blame = false,
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      on_attach = function()
        local gs = package.loaded.gitsigns

        map('n', '<leader>hn', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '<leader>hp', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hc', gs.preview_hunk)
        map('n', '<F2>', gs.toggle_signs)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>hB', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        -- map('n', '<leader>td', gs.toggle_deleted)
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }

  end
}
