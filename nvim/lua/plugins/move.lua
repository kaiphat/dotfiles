__.add_plugin {
	'smoka7/hop.nvim',
	version = 'v2',
	event = 'BufReadPre',
	keys = {
		{
			's',
			function(_)
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
