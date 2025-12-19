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
				-- heading = {
				-- 	sign = true,
				-- 	icons = { '◇ ', '◇ ', '◇ ', '◇ ', '◇ ', '◇ ' },
				-- },
				-- code = {
				-- 	style = 'normal',
				-- 	width = 'full',
				-- 	border = 'thick',
				-- },
				bullet = {
					icons = { '•', '◦', '■', '◇ ' },
				},
				completions = {
					lsp = {
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
