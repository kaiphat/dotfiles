return {
	dir = './',
	event = 'BufReadPre',
	config = function()
		require('local_plugins.marks'):setup()
	end,
}
