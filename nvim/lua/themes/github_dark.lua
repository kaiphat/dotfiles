return {
	'projekt0n/github-nvim-theme',
	lazy = false,
	priority = 1000,
	config = function()
		require('github-theme').setup {
			options = {
				transparent = true,

				darken = {
					floats = false,
				},

				styles = {
					comments = 'italic',
					keywords = 'italic,bold',
				},
			},

			palletes = {
				all = {},
			},

			groups = {
				all = {
					TreesitterContext = { bg = 'sel0' },
					NoicePopupmenuSelected = { bg = 'sel0' },
					TelescopeSelection = { bg = 'sel0' },
					NormalFloat = { bg = 'NONE', fg = 'fg1' },
					MatchParen = { bg = 'sel2' },
					IncSearch = { bg = 'sel2' },
					MiniTrailspace = { bg = 'bg2' },
					Pmenu = { bg = 'bg2' },
					FloatBorder = { fg = 'bg3' },
					TelescopeBorder = { fg = 'bg3' },
					NoiceCmdlinePopupBorder = { fg = 'bg3' },
					NoiceCmdlinePopupBorderSearch = { fg = 'bg3' },
					StatusLine = { bg = 'NONE', fg = 'bg2' },
					StatusLineNC = { bg = 'NONE', fg = 'bg1' },
				},
			},
		}

        vim.cmd 'colorscheme github_dark_tritanopia'
	end,
}
