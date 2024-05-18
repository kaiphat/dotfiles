return {
	dir = '../local_plugins/marks',
	event = 'VeryLazy',
	name = 'marks',
	enabled = true,
	config = function()
		require('local_plugins.marks').setup {
			save_position = false,
		}
	end,
}
