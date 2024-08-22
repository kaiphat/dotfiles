local constants = require 'constants'
local icons = constants.icons

return {
	{
		'echasnovski/mini.align',
		event = 'BufReadPre',
		opts = {},
	},

	{
		'echasnovski/mini.splitjoin',
		event = 'BufReadPre',
		opts = {},
	},

	{
		'echasnovski/mini.surround',
		event = 'BufReadPre',
		config = function()
			local key = '<leader>'

			require('mini.surround').setup {
				mappings = {
					add = key .. 'sa',
					delete = key .. 'sd',
					find = key .. 'sf',
					find_left = key .. 'sF',
					highlight = key .. 'sh',
					replace = key .. 'sr',
					update_n_lines = key .. 'sn',
				},
				custom_surroundings = {
					['('] = { output = { left = '(', right = ')' } },
					['['] = { output = { left = '[', right = ']' } },
					['{'] = { output = { left = '{', right = '}' } },
					['<'] = { output = { left = '<', right = '>' } },
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
				function()
					require('mini.trailspace').trim()
				end,
			},
		},
		opts = {},
	},

	{
		'echasnovski/mini.indentscope',
		enabled = false,
		event = 'BufReadPre',
		opts = {
			draw = {
				delay = 100,
			},
			mappings = {
				object_scope = 'ii',
				object_scope_with_border = 'ai',

				goto_top = '[i',
				goto_bottom = ']i',
			},
			options = {
				border = 'both',
				indent_at_cursor = true,
				try_as_border = false,
			},
			symbol = icons.VERTICAL_LINE_1,
		},
	},

	{
		'echasnovski/mini.cursorword',
		version = false,
		event = 'BufReadPre',
		opts = {
			delay = 400,
		},
	},

	{
		'echasnovski/mini.icons',
		event = 'VeryLazy',
		version = false,
		opts = {
			lsp = {
				snippet = { glyph = '', hl = 'MiniIconsGreen' },
			},
		},
	},

	{
		'echasnovski/mini.pairs',
		enabled = false,
		config = function()
			local pairs = require 'mini.pairs'

			pairs.setup {
				modes = { insert = true, command = false, terminal = false },
				mappings = {
					['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%)a-zA-Z]' },
					['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%]a-zA-Z]' },
					['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%}a-zA-Z]' },

					[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
					[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
					['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

					['"'] = {
						action = 'closeopen',
						pair = '""',
						neigh_pattern = '[^\\][^"a-zA-Z]',
						register = { cr = false },
					},
					['\''] = {
						action = 'closeopen',
						pair = '\'\'',
						neigh_pattern = '[^%a\\][^\'a-zA-Z]',
						register = { cr = false },
					},
					['`'] = {
						action = 'closeopen',
						pair = '``',
						neigh_pattern = '[^\\][^`a-zA-Z]',
						register = { cr = false },
					},
				},
			}
		end,
	},
}
