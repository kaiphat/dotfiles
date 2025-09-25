local icons = kaiphat.constants.icons

return {
	{
		'echasnovski/mini.align',
		event = 'BufReadPre',
		opts = {},
	},

	{
		'echasnovski/mini.splitjoin',
		event = 'BufReadPre',
		enabled = false,
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
		enabled = false,
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
		event = 'VeryLazy',
		enabled = false,
		opts = {
			delay = 150,
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
		event = 'VeryLazy',
		config = function()
			require('mini.pairs').setup {
				modes = { insert = true, command = false, terminal = false },
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				skip_ts = { 'string' },
				skip_unbalanced = true,
				markdown = true,
				-- mappings = {
				-- 	['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
				-- 	['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
				-- 	['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
				--
				-- 	[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
				-- 	[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
				-- 	['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
				--
				-- 	['"'] = {
				-- 		action = 'closeopen',
				-- 		pair = '""',
				-- 		neigh_pattern = '[^\\].',
				-- 		register = { cr = false },
				-- 	},
				-- 	['\''] = {
				-- 		action = 'closeopen',
				-- 		pair = '\'\'',
				-- 		neigh_pattern = '[^%a\\].',
				-- 		register = { cr = false },
				-- 	},
				-- 	['`'] = {
				-- 		action = 'closeopen',
				-- 		pair = '``',
				-- 		neigh_pattern = '[^\\].',
				-- 		register = { cr = false },
				-- 	},
				-- },
			}
		end,
	},

	{
		'echasnovski/mini.ai',
		event = 'VeryLazy',
		enabled = false,
		config = function()
			local ai = require 'mini.ai'
			ai.setup {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter { -- code block
						a = { '@block.outer', '@conditional.outer', '@loop.outer' },
						i = { '@block.inner', '@conditional.inner', '@loop.inner' },
					},
					f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
					c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
					t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
					d = { '%f[%d]%d+' }, -- digits
					e = { -- Word with case
						{
							'%u[%l%d]+%f[^%l%d]',
							'%f[%S][%l%d]+%f[^%l%d]',
							'%f[%P][%l%d]+%f[^%l%d]',
							'^[%l%d]+%f[^%l%d]',
						},
						'^().*()$',
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
				},
			}
		end,
	},

	{
		'echasnovski/mini.bracketed',
		enabled = false,
		event = 'VeryLazy',
		config = function()
			require('mini.bracketed').setup {}
		end,
	},
}
