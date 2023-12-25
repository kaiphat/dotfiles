return {
	dir = './',
	keys = {
		{
			'u',
			function()
                require('local_plugins.unit'):select(true)
			end,
			mode = { 'x', 'o' },
		},
        {
            '[c',
            function()
                require('local_plugins.unit'):jump_to_parent_unit()
            end
        },
        {
            '[[',
            function()
                require('local_plugins.unit'):jump_to_neighbor_unit {
                    direction = 'up',
                }
            end
        },
        {
            ']]',
            function()
                require('local_plugins.unit'):jump_to_neighbor_unit {
                    direction = 'down',
                }
            end
        },
	},
	dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
	config = function()
		require('local_plugins.unit'):setup()
	end,
}
