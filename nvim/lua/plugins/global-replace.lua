return {
	{
		'MagicDuck/grug-far.nvim',
		keys = {
			{
				'<leader>r',
				function()
					require('grug-far').open()
				end,
			},
			{
				'<leader>R',
				function()
					require('grug-far').open {
						prefills = {
							paths = vim.fn.expand '%',
						},
					}
				end,
			},
		},
		config = function()
			vim.g.maplocalleader = ','

			require('grug-far').setup {
				startInInsertMode = false,
			}
		end,
	},
}
