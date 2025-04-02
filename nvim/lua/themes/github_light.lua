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
					NormalFloat = { bg = 'NONE' },
					MatchParen = { bg = 'sel2' },
					IncSearch = { bg = 'sel2' },
					MiniTrailspace = { bg = 'bg2' },
					Pmenu = { bg = 'bg2' },
					IndentBlanklineChar = { fg = '#ccccec' },
					IndentBlanklineContextChar = { fg = '#ccccec' },
					StatusLine = { bg = 'NONE', fg = 'bg2' },
					StatusLineNC = { bg = 'NONE', fg = 'bg1' },
					HopNextKey1 = { link = 'HopNextKey' },
					HopNextKey2 = { link = 'HopNextKey' },
					SnacksIndent = { fg = '#ccccec' },
					['@punctuation'] = { fg = '#666666' },
				},
			},
		}

		local themes = {
			github_light_tritanopia = 'github_light_tritanopia',
			github_light_default = 'github_light_default',
			github_light_high_contrast = 'github_light_high_contrast',
			github_light_colorblind = 'github_light_colorblind',
		}

		vim.cmd('colorscheme ' .. themes.github_light_high_contrast)
	end,
}
