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
--     alt = "#abbceb",
--     bg = "#1b1a20",
--     border = "#393842",
--     builtin = "#8da0d6",
--     comment = "#686675",
--     constant = "#e67e80",
--     dim = "#121112",
--     fg = "#bbbac1",
--     float = "#2d2b36",
--     func = "#53a8b8",
--     keyword = "#e69875",
--     line = "#1f1e26",
--     operator = "#9b99a3",
--     preproc = "#b39581",
--     property = "#8c8abd",
--     string = "#dbbc8a",
--     type = "#d6a56f",
--     visual = "#413f4d",
--     error = "#e67e80",
--     hint = "#8da0d6",
--     warning = "#ad9368",
--     delta = "#8da0d6",
--     plus = "#a7c080",

-- let s:uno_1 = '#d6e9ff'
--    let s:uno_2 = '#abb2bf'
--    let s:uno_3 = '#6e88a6'
--    let s:uno_4 = '#55606d'
--
--    let s:duo_1 = '#c8ae9d'
--    let s:duo_2 = '#e06c75'
--    let s:duo_3 = '#dd672c'
--
--    let s:syntax_color_renamed  = '#33a0ff'
--    let s:syntax_color_added    = '#43d08a'
--    let s:syntax_color_modified = '#e0c285'
--    let s:syntax_color_removed  = '#e05252'
--
--    let s:syntax_fg               = s:uno_2
--    let s:syntax_bg               = '#282c34'
--    let s:syntax_accent           = '#56b6c2'
--    let s:syntax_gutter           = '#636d83'
--    let s:syntax_selection        = '#3e4452'
--    let s:syntax_fold_bg          = '#5c6370'
--    let s:syntax_cursor_line      = '#2c323c'
--  endif
--

local visual = '#3e4452'

return {
	'cdmill/neomodern.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('neomodern').setup {
			style = 'campfire', -- choose between 'iceclimber', 'coffeecat', 'darkforest', 'campfire', 'roseprime', 'daylight'
			transparent = true, -- don't set background
			code_style = {
				keywords = 'italic',
			},
			colors = {
				border = visual,
				comment = '#636d83',
				highlight = visual,
				visual = visual,
				bg = visual,
				dim = visual,
				line = visual,
				func = '#a3b8ef',
				fg = '#c0caf5',
				plus = '#9CC4B2',
				keyword = '#e67e80',
				error = '#e67e80',
				constant = '#c8ae9d',
				preproc = '#c8ae9d',
				type = '#c8ae9d',
				string = '#c8ae9d',
				property = '#6e88a6',
			},
			highlights = {
				MiniCursorword = { underline = false, bg = '$highlight' },
				Visual = { bg = '$highlight' },
				FloatBorder = { fg = '$border', bg = 'NONE' },
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
