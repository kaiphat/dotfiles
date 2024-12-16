return {
	'aaronik/treewalker.nvim',
	event = 'VeryLazy',
	keys = {
		{
			'[[',
			function()
				vim.cmd 'Treewalker Up'
			end,
		},
		{
			']]',
			function()
				vim.cmd 'Treewalker Down'
			end,
		},
	},
	opts = {},
}
