return {
	'anuvyklack/windows.nvim',
	dependencies = {
		'anuvyklack/middleclass',
	},
	enabled = true,
	event = 'BufReadPre',
	config = function()
		local windows = require 'windows'

		windows.setup {
			autowidth = {
				enable = true,
				winwidth = 50,
				winminwidth = 10,
				filetype = {
					help = 2,
				},
			},

			ignore = {
				buftype = { 'quickfix' },
				filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' },
			},

			animation = {
				enable = false,
			},
		}
	end,
}
