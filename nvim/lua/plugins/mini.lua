__.add_plugin {
	'nvim-mini/mini.align',
	event = 'BufReadPost',
}

__.add_plugin {
	'nvim-mini/mini.surround',
	event = 'BufReadPost',
	load = function(_)
		local key = '<leader>'

		_.setup {
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
}

__.add_plugin {
	'nvim-mini/mini.icons',
	opts = {
		lsp = {
			snippet = { glyph = '', hl = 'MiniIconsGreen' },
		},
	},
}
