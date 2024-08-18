return {
	{
		'MeanderingProgrammer/markdown.nvim',
		ft = 'markdown',
		name = 'render-markdown',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
				},
				bullet = {
					icons = { '•', '◦', '■', '◇ ' },
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
