__.add_plugin {
	'Wansmer/treesj',
	keys = {
		{
			'gS',
			function(_)
				_.toggle()
			end,
		},
	},
	opts = {
		use_default_keymaps = false,
		check_syntax_error = false,
		max_join_length = 4000,
	},
}
