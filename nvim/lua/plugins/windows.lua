__.add_plugin {
	'anuvyklack/middleclass',
	skip_require = true,
}

__.add_plugin {
	'anuvyklack/windows.nvim',
	deps = {
		'middleclass',
	},
	event = 'BufReadPost',
	opst = {
		autowidth = {
			enable = true,
			winwidth = 40,
			winminwidth = 10,
			filetype = {
				help = 2,
				oil = 1,
			},
		},

		ignore = {
			buftype = { 'quickfix' },
			filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' },
		},

		animation = {
			enable = false,
			duration = 100,
		},
	},
}
