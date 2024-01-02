return {
	dir = '../local_plugins/marks',
	event = 'VeryLazy',
	config = function()
		require('local_plugins.marks'):setup()
	end,
}
