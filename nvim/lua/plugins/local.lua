__.add_plugin {
	dir = 'local_plugins.anchor',
	event = 'BufReadPre',
}

__.add_plugin {
	dir = 'local_plugins.unit',
	keys = {
		{
			'u',
			function(_)
				_.select(true)
			end,
			mode = { 'x', 'o' },
		},
	},
	deps = {
		'nvim-treesitter',
	},
}

__.add_plugin {
	dir = 'local_plugins.restore',
	keys = {
		{
			'<leader>ur',
			function(_)
				_.restore()
			end,
		},
	},
}

__.add_plugin {
	dir = 'local_plugins.cursorword',
	event = 'BufReadPre',
}
