return {
	name = 'restore',
	dir = '../local_plugins/restore',
	keys = {
		{
			'<leader>ur',
			function()
				require('local_plugins.restore'):restore()
			end,
		},
	},
	event = 'VeryLazy',
	config = function()
		require('local_plugins.restore').setup()
	end,
}
