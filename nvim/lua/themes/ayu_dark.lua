return {
	'Shatur/neovim-ayu',
	priority = 1000,
	config = function()
		vim.o.background = 'dark'

		require('ayu').setup {
			terminal = true,
			overrides = {
				Normal = { bg = 'None' },
				ColorColumn = { bg = 'None' },
				SignColumn = { bg = 'None' },
				Folded = { bg = 'None' },
				FoldColumn = { bg = 'None' },
				CursorLine = { bg = 'None' },
				CursorColumn = { bg = 'None' },
				WhichKeyFloat = { bg = 'None' },
				VertSplit = { bg = 'None', fg = '#282c34' },
			},
		}

		vim.cmd.colorscheme 'ayu-mirage'
	end,
}
