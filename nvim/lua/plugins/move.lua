return {
	{
		'phaazon/hop.nvim',
		branch = 'v2',
		event = 'VeryLazy',
		enabled = true,
		keys = {
			{
				's',
				function()
					require('hop').hint_char1 {}
				end,
			},
		},
		config = function()
			local hop = require 'hop'

			hop.setup {
				keys = 'jkldfsahpioqwertyuzxcvbnm',
				case_insensitive = false,
				-- uppercase_labels = true,
			}
		end,
	},
}
