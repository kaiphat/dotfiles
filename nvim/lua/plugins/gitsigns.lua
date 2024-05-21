local base_keys = '<leader>h'

return {
	'lewis6991/gitsigns.nvim',
	event = 'BufReadPre',
	keys = {
		{
			base_keys .. 'n',
			function()
				if vim.wo.diff then
					return ']c'
				end
				vim.schedule(function()
					require('gitsigns').next_hunk()
				end)
				return '<Ignore>'
			end,
		},
		{
			base_keys .. 'p',
			function()
				if vim.wo.diff then
					return '[c'
				end
				vim.schedule(function()
					require('gitsigns').prev_hunk()
				end)
				return '<Ignore>'
			end,
		},
		{
			base_keys .. 'S',
			function()
				require('gitsigns').stage_buffer()
			end,
		},
		{
			base_keys .. 'u',
			function()
				require('gitsigns').undo_stage_hunk()
			end,
		},
		{
			base_keys .. 'R',
			function()
				require('gitsigns').reset_buffer()
			end,
		},
		{
			base_keys .. 'c',
			function()
				require('gitsigns').preview_hunk()
			end,
		},
		{
			base_keys .. 'b',
			function()
				require('gitsigns').blame_line { full = true }
			end,
		},
		{
			base_keys .. 'B',
			function()
				require('gitsigns').toggle_current_line_blame()
			end,
		},
		{
			base_keys .. 'd',
			function()
				require('gitsigns').diffthis()
			end,
		},
		{
			base_keys .. 'D',
			function()
				require('gitsigns').diffthis '~'
			end,
		},
		{
			base_keys .. 's',
			function()
				require('gitsigns').stage_hunk()
			end,
			mode = { 'n', 'v' },
		},
		{
			base_keys .. 'r',
			function()
				require('gitsigns').reset_hunk()
			end,
			mode = { 'n', 'v' },
		},
		{
			'ih',
			function()
				require('gitsigns').select_hunk()
			end,
			mode = { 'o', 'x' },
		},
	},
	config = function()
		local gitsigns = require 'gitsigns'
		local icon = ICONS.VERTICAL_LINE_SHORT_1

		gitsigns.setup {
			signs = {
				add = {
					hl = 'GitSignsAdd',
					text = icon,
					numhl = 'GitSignsAddNr',
					linehl = 'GitSignsAddLn',
				},
				change = {
					hl = 'GitSignsChange',
					text = icon,
					numhl = 'GitSignsChangeNr',
					linehl = 'GitSignsChangeLn',
				},
				delete = {
					hl = 'GitSignsDelete',
					text = icon,
					numhl = 'GitSignsDeleteNr',
					linehl = 'GitSignsDeleteLn',
				},
				topdelete = {
					hl = 'GitSignsDelete',
					text = icon,
					numhl = 'GitSignsDeleteNr',
					linehl = 'GitSignsDeleteLn',
				},
				changedelete = {
					hl = 'GitSignsChange',
					text = icon,
					numhl = 'GitSignsChangeNr',
					linehl = 'GitSignsChangeLn',
				},
				untracked = {
					hl = 'GitSignsAdd',
					text = icon,
					numhl = 'GitSignsAddNr',
					linehl = 'GitSignsAddLn',
				},
			},
			signcolumn = true,
			linehl = false,
			numhl = false,
			current_line_blame = false,
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			_signs_staged_enable = true,
			_signs_staged = {
				add = {
					hl = 'GitSignsAdd',
					text = icon,
					numhl = 'GitSignsAddNr',
					linehl = 'GitSignsAddLn',
				},
				change = {
					hl = 'GitSignsChange',
					text = icon,
					numhl = 'GitSignsChangeNr',
					linehl = 'GitSignsChangeLn',
				},
				delete = {
					hl = 'GitSignsDelete',
					text = icon,
					numhl = 'GitSignsDeleteNr',
					linehl = 'GitSignsDeleteLn',
				},
				topdelete = {
					hl = 'GitSignsDelete',
					text = icon,
					numhl = 'GitSignsDeleteNr',
					linehl = 'GitSignsDeleteLn',
				},
				changedelete = {
					hl = 'GitSignsChange',
					text = icon,
					numhl = 'GitSignsChangeNr',
					linehl = 'GitSignsChangeLn',
				},
				untracked = {
					hl = 'GitSignsAdd',
					text = icon,
					numhl = 'GitSignsAddNr',
					linehl = 'GitSignsAddLn',
				},
			},
		}
	end,
}
