return {
	'Shatur/neovim-ayu',
	priority = 1000,
	config = function()
		require('ayu').setup {
			overrides = {
				Normal = { bg = 'None' },
				ColorColumn = { bg = 'None' },
				SignColumn = { bg = 'None' },
				Folded = { bg = 'None' },
				FoldColumn = { bg = 'None' },
				CursorLine = { bg = 'None' },
				CursorColumn = { bg = 'None' },
				WhichKeyFloat = { bg = 'None' },
				VertSplit = { bg = 'None' },
                MiniCursorword = { link = 'Visual' }
			},
		}

        vim.cmd.colorscheme('ayu-light')
	end,
}
