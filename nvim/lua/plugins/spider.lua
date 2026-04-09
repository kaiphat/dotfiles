__.add_plugin {
	'chrisgrieser/nvim-spider',
	event = 'BufReadPre',
	keys = {
		{
			'w',
			function(_)
				_.motion 'w'
			end,
			mode = { 'n', 'o', 'x' },
		},
		{
			'e',
			function(_)
				_.motion 'e'
			end,
			mode = { 'n', 'o', 'x' },
		},
		{
			'b',
			function(_)
				_.motion 'b'
			end,
			mode = { 'n', 'o', 'x' },
		},
		{
			'ge',
			function(_)
				_.motion 'ge'
			end,
			mode = { 'n', 'o', 'x' },
		},
	},
	opts = {
		skipInsignificantPunctuation = false,
	},
}
