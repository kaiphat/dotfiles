return {
	{
		'anuvyklack/windows.nvim',
		dependencies = {
			'anuvyklack/middleclass',
			-- 'anuvyklack/animation.nvim',
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
					enable = false,
					duration = 100,
				},
			}
		end,
	},

	{
		'shortcuts/no-neck-pain.nvim',
		event = 'VeryLazy',
		enabled = false,
		config = function()
			require('no-neck-pain').setup {
				autocmds = {
					enableOnVimEnter = true,
				},
			}
		end,
	},

	{
		'folke/edgy.nvim',
		event = 'VeryLazy',
		enabled = false,
		opts = {
			left = {
				{
					ft = 'aerial',
				},
			},
			options = {
				left = { size = 60 },
			},

			fix_win_height = false,

			animate = {
				enabled = false,
			},
		},
	},
}
