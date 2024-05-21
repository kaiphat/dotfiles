return {
	name = 'stages',
	dir = '../local_plugins/stages',
	lazy = false,
	enabled = false,
	keys = {
		{
			'[p',
			function()
				require('local_plugins.stages'):jump_to_parent()
			end,
		},
		{
			'[[',
			function()
				require('local_plugins.stages'):jump_up()
			end,
			ft = '*',
		},
		{
			']]',
			function()
				require('local_plugins.stages'):jump_down()
			end,
			ft = '*',
		},
	},
	config = function()
		require('local_plugins.stages'):setup()
	end,
}
