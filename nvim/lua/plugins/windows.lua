__.add_plugin {
	'anuvyklack/middleclass',
	load = function() end,
}

__.add_plugin {
	'anuvyklack/windows.nvim',
	deps = {
		'middleclass',
	},
	event = 'BufReadPre',
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
