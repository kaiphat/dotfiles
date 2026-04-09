__.add_plugin {
	'MagicDuck/grug-far.nvim',
	keys = {
		{
			'<leader>r',
			function(_)
				_.open()
			end,
		},
		{
			'<leader>R',
			function(_)
				_.open {
					prefills = {
						paths = vim.fn.expand '%',
					},
				}
			end,
		},
	},
	load = function(_)
		vim.g.maplocalleader = ','

		_.setup {
			startInInsertMode = false,
		}
	end,
}
