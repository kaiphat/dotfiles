return {
	{
		'lukas-reineke/headlines.nvim',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		enabled = false,
		ft = 'markdown',
		opts = {
			markdown = {
				fat_headlines = false,
				fat_headline_upper_string = '▃',
				-- fat_headline_lower_string = '🬂',
				fat_headline_lower_string = '▀',
				dash_string = '─',
				bullets = { '◉', '○', '✸', '✿' },
			},
		},
	},

	{
		'MeanderingProgrammer/markdown.nvim',
		ft = 'markdown', -- or 'event = "VeryLazy"'
		name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('render-markdown').setup {
                headings = { '◇ ', '◇ ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
                bullets = { '•', '◦', '■', '◇ ' },
			}
		end,
	},
}
