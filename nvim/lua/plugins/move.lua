return {
	{
		'phaazon/hop.nvim',
		branch = 'v2',
		event = 'VeryLazy',
		enabled = false,
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
		opts = {
			search = {
				multi_window = false,
				-- * exact: exact match -- default
				-- * search: regular search
				-- * fuzzy: fuzzy search
				mode = 'exact',
				-- incremental = true,
			},
			modes = {
				search = {
					bled = true,
					-- search = {
					-- incremental = true,
					-- },
				},
				char = {
					enabled = true,
				},
			},
		},
		-- keys = {
		-- 	{
		-- 		'S',
		-- 		mode = { 'n', 'x', 'o' },
		-- 		function()
		-- 			require('flash').treesitter()
		-- 		end,
		-- 		desc = 'Flash Treesitter',
		-- 	},
		-- },
	},
}
