-- _nc = "#16141f",
-- base = "#191724",
-- surface = "#1f1d2e",
-- overlay = "#26233a",
-- muted = "#6e6a86",
-- subtle = "#908caa",
-- text = "#e0def4",
-- love = "#eb6f92",
-- gold = "#f6c177",
-- rose = "#ebbcba",
-- pine = "#31748f",
-- foam = "#9ccfd8",
-- iris = "#c4a7e7",
-- highlight_low = "#21202e",
-- highlight_med = "#403d52",
-- highlight_high = "#524f67",
-- none = "NONE",

return {
	'rose-pine/neovim',
	priority = 1000,
	lazy = false,
	name = 'rose-pine',
	config = function()
		require('rose-pine').setup {
			dim_nc_background = false,
			disable_background = true,
			disable_float_background = true,

			highlight_groups = {
				Normal = { fg = '#908caa' },
				NormalNC = { fg = '#908caa' },
				GitSignsAdd = { bg = 'none' },
				GitSignsChange = { bg = 'none' },
				GitSignsDelete = { bg = 'none' },
				MiniCursorword = { underline = false, bg = 'foam', blend = 30 },
				MiniCursorwordCurrent = { underline = false, bg = 'NONE' },
				LocalHighlight = { underline = false, bg = 'foam', blend = 30 },
				HopNextKey1 = { fg = 'love' },
				HopNextKey2 = { fg = 'pine' },
				Keyword = { bold = true, italic = true },
				VertSplit = { fg = '#405879' },
				TreesitterContext = { bg = 'muted', blend = 15 },
				TreesitterContextSeparator = { fg = 'rose' },
				CmpItemKindCodeium = { fg = 'iris' },
				IndentBlanklineChar = { fg = 'overlay' },
				IndentBlanklineContextChar = { fg = 'overlay' },
				NoiceCmdlinePopupBorder = { link = 'NormalFloat' },
				['@variable'] = { italic = false, fg = '#c4c6e7' },
				['@lsp.type.property.typescript'] = { italic = false, fg = '#7a8bb1' },
				['@property.typescript'] = { italic = false, fg = '#7a8bb1' },
				['@attribute'] = { fg = 'iris' },
				['@neorg.headings.1.title'] = { fg = 'iris' },
				['@neorg.lists.unordered.prefix.norg'] = { fg = 'iris' },
				['@neorg.todo_items.done.norg'] = { fg = 'foam' },
				['@markup.raw.markdown_inline'] = { fg = 'rose' },
				['@punctuation'] = { fg = '#486892', italic = false },
				['@punctuation.bracket'] = { fg = '#486892' },
				['@punctuation.special'] = { fg = '#486892' },
				['@punctuation.delimiter'] = { fg = '#486892' },
				FzfLuaColorsBgSel = { fg = 'rose' },
				FzfLuaTitle = { bg = 'foam', fg = 'base', bold = false },
			},

			before_highlight = function(group, h, p)
				if h.fg == p.pine then
					h.fg = '#6e88a6'
				end
				if h.bg == p.pine then
					h.bg = '#6e88a6'
				end

				-- if highlight.fg == palette.gold then
				-- 	highlight.fg = '#9398cf'
				-- end
				-- if highlight.bg == palette.gold then
				-- 	highlight.bg = '#9398cf'
				-- end

				-- if highlight.fg == palette.foam then
				-- 	highlight.fg = '#81c8be'
				-- end
				-- if highlight.bg == palette.foam then
				-- 	highlight.bg = '#81c8be'
				-- end

				-- if highlight.fg == palette.rose then
				-- 	highlight.fg = '#6e88a6'
				-- end
				-- if highlight.bg == palette.rose then
				-- 	highlight.bg = '#6e88a6'
				-- end

				-- if highlight.fg == palette.iris then
				-- 	highlight.fg = '#babbf1'
				-- end
				-- if highlight.bg == palette.iris then
				-- 	highlight.bg = '#babbf1'
				-- end
			end,
		}

		vim.cmd 'colorscheme rose-pine'
	end,
}
