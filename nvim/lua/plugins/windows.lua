return {
	'anuvyklack/windows.nvim',
	dependencies = {
		'anuvyklack/middleclass',
		'anuvyklack/animation.nvim',
	},
	event = 'BufReadPre',
	enabled = false,
	config = function()
		local windows = require 'windows'
		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false

		windows.setup {
			autowidth = {
				enable = true,
				winwidth = 50,
				winminwidth = 10,
				filetype = {
					help = 2,
					-- oil = 1,
				},
			},

			ignore = {
				buftype = { 'quickfix' },
				filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' },
			},

			animation = {
				enable = true,
                duration = 150,
			},
		}
	end,
}
