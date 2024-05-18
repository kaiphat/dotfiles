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
			symbol = ICONS.VERTICAL_LINE_1,
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
}
