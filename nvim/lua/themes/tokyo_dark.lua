-- M.default = {
--   none = "NONE",
--   bg_dark = "#1f2335",
--   bg = "#24283b",
--   bg_highlight = "#292e42",
--   terminal_black = "#414868",
--   fg = "#c0caf5",
--   fg_dark = "#a9b1d6",
--   fg_gutter = "#3b4261",
--   dark3 = "#545c7e",
--   comment = "#565f89",
--   dark5 = "#737aa2",
--   blue0 = "#3d59a1",
--   blue = "#7aa2f7",
--   cyan = "#7dcfff",
--   blue1 = "#2ac3de",
--   blue2 = "#0db9d7",
--   blue5 = "#89ddff",
--   blue6 = "#b4f9f8",
--   blue7 = "#394b70",
--   magenta = "#bb9af7",
--   magenta2 = "#ff007c",
--   purple = "#9d7cd8",
--   orange = "#ff9e64",
--   yellow = "#e0af68",
--   green = "#9ece6a",
--   green1 = "#73daca",
--   green2 = "#41a6b5",
--   teal = "#1abc9c",
--   red = "#f7768e",
--   red1 = "#db4b4b",
--   git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
--   gitSigns = {
--     add = "#266d6a",
--     change = "#536c9e",
--     delete = "#b2555b",
--   },
-- }

return {
	'folke/tokyonight.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('tokyonight').setup {
			style = 'storm',
			transparent = true,

			styles = {
				sidebars = 'transparent',
				floats = 'transparent',
			},

			on_colors = function(c)
				c.border = c.comment
				c.comment = c.dark5
				c.yellow = '#f6c177'
                c.orange = '#6e88a6'
                c.blue1 = '#f4b8e4'
			end,

			on_highlights = function(hl, c)
				hl.FzfLuaBorder = { fg = c.terminal_black }
				hl.FzfLuaTitle = { bg = c.blue1, fg = c.terminal_black, bold = false }
				hl.StatusLine = { bg = 'NONE', fg = c.comment }
				hl.StatusLineNC = { bg = 'NONE', fg = c.comment }
				hl.FzfLuaHeaderText = { fg = c.green2 }
				hl.ColorColumn = { bg = c.fg_gutter }
			end,
		}

		vim.cmd 'colorscheme tokyonight'
	end,
}
