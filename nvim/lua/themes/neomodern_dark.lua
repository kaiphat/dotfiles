-- roseprime = {
--     alt = "#bbbac1",
--     bg = "#121212",
--     border = "#2e2e2f",
--     builtin = "#ba7685",
--     comment = "#555555",
--     constant = "#8192C7",
--     dim = "#111111",
--     fg = "#bbbac1",
--     float = "#212123",
--     func = "#ddadb4",
--     keyword = "#6b8f89",
--     line = "#1d1d1f",
--     operator = "#838196",
--     preproc = "#9879b0",
--     property = "#a3849b",
--     string = "#d2af98",
--     type = "#a3b8b5",
--     visual = "#26262a",
--     error = "#ba5f60",
--     hint = "#abbceb",
--     warning = "#ad9368",
--     delta = "#8192C7",
--     plus = "#6b8f89",
--   },

local visual = '#344556'

return {
	'cdmill/neomodern.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('neomodern').setup {
			style = 'roseprime', -- choose between 'iceclimber', 'coffeecat', 'darkforest', 'campfire', 'roseprime', 'daylight'
			transparent = true, -- don't set background
			colors = {
				border = visual,
				comment = '#667788',
				highlight = visual,
				visual = visual,
				bg = visual,
				dim = visual,
				line = visual,
			},
			highlights = {
				MiniCursorword = { underline = false, bg = '$highlight' },
				Visual = { bg = '$highlight' },
				FloatBorder = { fg = '$border' },
				FzfLuaBorder = { fg = '$border' },
				WinSeparator = { fg = '$visual' },
				ColorColumn = { fg = '$type' },
				IndentBlanklineChar = { fg = '$border' },
				IndentBlanklineContextChar = { fg = '$border' },
			},
		}

		require('neomodern').load()
	end,
}
