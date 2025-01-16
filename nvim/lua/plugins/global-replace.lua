return {
	{

		'nvim-pack/nvim-spectre',
		enabled = false,
		keys = {
			{
				'<leader>r',
				function()
					require('plugins.global-replace').toggle()
				end,
			},
		},
		config = function()
			require('plugins.global-replace').setup()
		end,
	},

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
