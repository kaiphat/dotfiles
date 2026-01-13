return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		ft = { 'markdown' },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'echasnovski/mini.icons',
		},
		enabled = true,
		config = function()
			vim.treesitter.language.register('markdown', 'copilot-chat')

			require('render-markdown').setup {
				file_types = { 'markdown', 'copilot-chat' },
				heading = {
					sign = false,
					icons = { '◇ ', '◇ ', '◇ ', '◇ ', '◇ ', '◇ ' },
				},
				code = {
					sign = false,
					style = 'full',
					width = 'full',
					border = 'thick',
					language = false,
					language_icon = false,
				},
				bullet = {
					icons = { '•', '◦', '■', '◇ ' },
				},
				completions = {
					lsp = {
						enabled = true,
					},
				},
				dash = {
					icon = '─',
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
