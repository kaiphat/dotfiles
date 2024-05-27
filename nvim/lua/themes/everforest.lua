return {
	'neanias/everforest-nvim',
	lazy = false,
	priority = 1000,
	version = false,
	config = function()
		vim.o.background = 'light'
		require('everforest').setup {
			theme = 'everforest',
			on_highlights = function(hl, p)
				hl.Normal = { bg = p.none }
				hl.NormalFloat = { bg = p.none }
				hl.NormalNC = { bg = p.none }
			end,
		}

		require('everforest').load()
	end,
}
