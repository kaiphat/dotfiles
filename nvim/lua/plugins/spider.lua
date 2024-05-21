return {
	'chrisgrieser/nvim-spider',
	event = 'BufReadPre',
	enabled = false,
	keys = {
		{
			'w',
			function()
				require('spider').motion 'w'
			end,
		},
		{
			'e',
			function()
				require('spider').motion 'e'
			end,
		},
		{
			'b',
			function()
				require('spider').motion 'b'
			end,
		},
		{
			'ge',
			function()
				require('spider').motion 'ge'
			end,
		},
	},
	config = function()
		require('spider').setup {
			skipInsignificantPunctuation = false,
		}
	end,
}
