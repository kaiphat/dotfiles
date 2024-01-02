return {
	'rose-pine/neovim',
	priority = 1000,
	lazy = false,
	name = 'rose-pine',
	config = function()
		require('rose-pine').setup {
			variant = 'moon',
			dark_variant = 'moon',
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
				LocalHighlight = { underline = false, bg = 'foam', blend = 30 },
				HopNextKey1 = { fg = 'love' },
				HopNextKey2 = { fg = 'pine' },
				Keyword = { bold = true, italic = true },
				VertSplit = { fg = '#405879' },
				TreesitterContext = { bg = 'muted', blend = 15 },
				TreesitterContextSeparator = { fg = 'rose' },
				CmpItemKindCodeium = { fg = 'iris' },
				IndentBlanklineChar = { fg = '#333366' },
                IndentBlanklineContextChar = { fg = '#333366' },
				['@variable'] = { italic = false, fg = '#c4c6e7' },
				['@lsp.type.property.typescript'] = { italic = false, fg = '#7a8bb1' },
				['@property.typescript'] = { italic = false, fg = '#7a8bb1' },
				['@punctuation'] = { italic = false },
				['@attribute'] = { fg = 'iris' },
				['@neorg.headings.1.title'] = { fg = 'iris' },
				['@neorg.lists.unordered.prefix.norg'] = { fg = 'iris' },
				['@neorg.todo_items.done.norg'] = { fg = 'foam' },
			},
		}

		vim.cmd 'colorscheme rose-pine-moon'
	end,
}
