local M = {}

M.char = '▏'

M.base_keys = '<leader>g'

return {
	'lewis6991/gitsigns.nvim',
	event = 'BufReadPre',
	keys = {
		{
			M.base_keys .. 'n',
			function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() require('gitsigns').next_hunk() end)
				return '<Ignore>'
			end,
		},
		{
			M.base_keys .. 'p',
			function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() require('gitsigns').prev_hunk() end)
				return '<Ignore>'
			end,
		},
		{ M.base_keys .. 'S', function() require('gitsigns').stage_buffer() end },
		{ M.base_keys .. 'u', function() require('gitsigns').undo_stage_hunk() end },
		{ M.base_keys .. 'R', function() require('gitsigns').reset_buffer() end },
		{ M.base_keys .. 'c', function() require('gitsigns').preview_hunk() end },
		{ M.base_keys .. 'b', function() require('gitsigns').blame_line { full = true } end },
		{ M.base_keys .. 'B', function() require('gitsigns').toggle_current_line_blame() end },
		{ M.base_keys .. 'd', function() require('gitsigns').diffthis() end },
		{ M.base_keys .. 'D', function() require('gitsigns').diffthis '~' end },
		{ M.base_keys .. 's', function() require('gitsigns').stage_hunk() end, mode = { 'n', 'v' } },
		{ M.base_keys .. 'r', function() require('gitsigns').reset_hunk() end, mode = { 'n', 'v' } },
		{ 'ih', function() require('gitsigns').select_hunk() end, mode = { 'o', 'x' } },
	},
	config = function()
		local gitsigns = require 'gitsigns'

		gitsigns.setup {
			signs = {
				add = { hl = 'GitSignsAdd', text = M.char, numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
				change = {
					hl = 'GitSignsChange',
					text = M.char,
					numhl = 'GitSignsChangeNr',
					linehl = 'GitSignsChangeLn',
				},
				delete = {
					hl = 'GitSignsDelete',
					text = M.char,
					numhl = 'GitSignsDeleteNr',
					linehl = 'GitSignsDeleteLn',
				},
				topdelete = {
					hl = 'GitSignsDelete',
					text = M.char,
					numhl = 'GitSignsDeleteNr',
					linehl = 'GitSignsDeleteLn',
				},
				changedelete = {
					hl = 'GitSignsChange',
					text = M.char,
					numhl = 'GitSignsChangeNr',
					linehl = 'GitSignsChangeLn',
				},
				untracked = { hl = 'GitSignsAdd', text = M.char, numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
			},
			signcolumn = true,
			linehl = false,
			numhl = false,
			current_line_blame = false,
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
            _signs_staged_enable = true,
		}
	end,
}
