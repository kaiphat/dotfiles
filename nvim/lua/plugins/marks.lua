return {
	dir = '../local_plugins/marks',
	event = 'VeryLazy',
	name = 'marks',
	config = function()
		require('local_plugins.marks').setup()
	end,
}
