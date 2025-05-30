return {
	{
		'MeanderingProgrammer/markdown.nvim',
		ft = 'markdown',
		name = 'render-markdown',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'echasnovski/mini.icons',
		},
		enabled = true,
		config = function()
			require('render-markdown').setup {
				heading = {
					sign = false,
					icons = { '◇ ', '◇ ', '◇ ', '◇ ', '◇ ', '◇ ' },
				},
				code = {
					style = 'normal',
					width = 'full',
					border = 'thick',
				},
				bullet = {
					icons = { '•', '◦', '■', '◇ ' },
				},
				completions = {
					blink = {
						enabled = true,
					},
				},
			}
		end,
	},

	{
		'OXY2DEV/markview.nvim',
		-- lazy = false, -- Recommended
		ft = 'markdown', -- If you decide to lazy-load anyway
		enabled = false,
	},
}
