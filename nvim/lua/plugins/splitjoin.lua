return {
	'Wansmer/treesj',
	keys = {
		{
			'gS',
			function()
				require('treesj').toggle()
			end,
		},
	},
	config = function()
		require('treesj').setup {
			use_default_keymaps = false,
			check_syntax_error = false,
			max_join_length = 2000,
		}
	end,
}
