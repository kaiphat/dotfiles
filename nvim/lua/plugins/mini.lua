local M = {}

M.chars = {
	'▏',
	'│',
	'⏐',
	'┊',
	'¦',
}

return {
	{
		'echasnovski/mini.align',
		event = 'BufReadPre',
		config = function()
			local align = require 'mini.align'

			align.setup {}
		end,
	},

	{
		'echasnovski/mini.splitjoin',
		event = 'BufReadPre',
		config = function()
			local m = require 'mini.splitjoin'

			m.setup {}
		end,
	},

	{
		'echasnovski/mini.surround',
		event = 'BufReadPre',
		config = function()
			local m = require 'mini.surround'

			local key = '<leader>'
			m.setup {
				mappings = {
					add = key .. 'sa',
					delete = key .. 'sd',
					find = key .. 'sf',
					find_left = key .. 'sF',
					highlight = key .. 'sh',
					replace = key .. 'sr',
					update_n_lines = key .. 'sn',
				},
			}
		end,
	},

	{
		'echasnovski/mini.trailspace',
		event = 'BufReadPre',
		keys = {
			{
				'<leader>ut',
				function() require('mini.trailspace').trim() end,
			},
		},
		config = function()
			local trail = require 'mini.trailspace'

			trail.setup {}
		end,
	},

	{
		'echasnovski/mini.comment',
		event = 'BufReadPre',
		config = function()
			local comment = require 'mini.comment'

			comment.setup {
				mappings = {
					comment = 'gc',
					comment_line = 'gcc',
					textobject = 'gc',
				},
			}
		end,
	},

	{
		'echasnovski/mini.indentscope',
		enabled = true,
		event = 'BufReadPre',
		config = function()
			local indent = require 'mini.indentscope'

			indent.setup {
				draw = {
					delay = 100,
				},

				mappings = {},

				options = {
					border = 'both',
					indent_at_cursor = true,
					try_as_border = false,
				},

				symbol = M.chars[1],
			}
		end,
	},

	{
		'echasnovski/mini.cursorword',
		version = false,
		event = 'BufReadPre',
		config = function()
			require('mini.cursorword').setup {
				delay = 200,
			}
		end,
	},
}
