return {
    name = 'unit',
	dir = '../local_plugins/unit',
	keys = {
		{
			'u',
			function()
                require('local_plugins.unit'):select(true)
			end,
			mode = { 'x', 'o' },
		},
	},
	dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
	config = function()
		require('local_plugins.unit'):setup()
	end,
}
