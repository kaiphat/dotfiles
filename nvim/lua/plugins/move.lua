__.add_plugin {
	'phaazon/hop.nvim',
	version = 'v2',
	event = 'BufReadPre',
	keys = {
		{
			's',
			function(_k)
				_.hint_char1 {}
			end,
		},
	},
	opts = {
		keys = 'jkldfsahpioqwertyuzxcvbnm',
		case_insensitive = false,
		-- uppercase_labels = true,
	},
}
