return {
	{
		'phaazon/hop.nvim',
		branch = 'v2',
		lazy = true,
		enabled = false,
		keys = {
			{
				's',
				function()
					require('plugins.move').hint_char1 {}
				end,
			},
		},
		config = function()
			local hop = require 'plugins.move'

			hop.setup {
				keys = 'jkdfaslhpioqwertyuzxcvbnm',
				case_insensitive = false,
				-- uppercase_labels = true,
			}
		end,
	},
	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		opts = {},
		keys = {
			{
				's',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').jump()
				end,
				desc = 'Flash',
			},
			{
				'S',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').treesitter()
				end,
				desc = 'Flash Treesitter',
			},
		},
	},
}
