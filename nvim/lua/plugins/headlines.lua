return {
	'lukas-reineke/headlines.nvim',
	dependencies = 'nvim-treesitter/nvim-treesitter',
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
}
