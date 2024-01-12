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
        {
            '[c',
            function()
                require('local_plugins.unit'):jump_to_parent_indent()
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
