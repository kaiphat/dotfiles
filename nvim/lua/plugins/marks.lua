return {
	dir = '../local_plugins/marks',
	event = 'BufReadPre',
	config = function()
		require('local_plugins.marks'):setup()
	end,
}
