return {
	'rebelot/kanagawa.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('kanagawa').setup {
			compile = false,
			transparent = true,
			dimInactive = false,
			theme = 'wave',

			colors = {
				theme = {
					all = {
						ui = {
							float = { bg = 'none' },
							bg_gutter = 'none',
						},
					},
				},
			},

			overrides = function(colors)
				return {
					NormalFloat = { bg = 'none' },
					FloatBorder = { bg = 'none' },
					FloatTitle = { bg = 'none' },

					TelescopeBorder = { bg = 'none' },
					MiniCursorword = { underline = false, bg = colors.palette.waveBlue2 },

					IndentBlanklineChar = { fg = colors.palette.sumiInk3 },
					IndentBlanklineContextChar = { fg = colors.palette.sumiInk3 },
				}
			end,
		}

		vim.cmd 'colorscheme kanagawa'
	end,
}
