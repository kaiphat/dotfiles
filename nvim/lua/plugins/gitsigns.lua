local icons = require('constants').icons
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
		local icon = icons.VERTICAL_LINE_SHORT_1

		gitsigns.setup {
			signs = {
				add = {
					text = icon,
				},
				change = {
					text = icon,
				},
				delete = {
					text = icon,
				},
				topdelete = {
					text = icon,
				},
				changedelete = {
					text = icon,
				},
				untracked = {
					text = icon,
				},
			},
			signcolumn = true,
			linehl = false,
			numhl = false,
			current_line_blame = false,
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			signs_staged_enable = true,
			signs_staged = {
				add = {
					text = icon,
				},
				change = {
					text = icon,
				},
				delete = {
					text = icon,
				},
				topdelete = {
					text = icon,
				},
				changedelete = {
					text = icon,
				},
			},
			preview_config = {
				border = 'rounded',
			},
		}
	end,
}
