return {
	'anuvyklack/windows.nvim',
	dependencies = {
		'anuvyklack/middleclass',
		'anuvyklack/animation.nvim',
	},
	event = 'BufReadPre',
	enabled = true,
	config = function()
		local windows = require 'windows'

		windows.setup {
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
				enable = true,
				duration = 100,
			},
		}
	end,
}
