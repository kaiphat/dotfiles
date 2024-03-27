--  rosewater = "#f2d5cf",
-- 	flamingo = "#eebebe",
-- 	pink = "#f4b8e4",
-- 	mauve = "#ca9ee6",
-- 	red = "#e78284",
-- 	maroon = "#ea999c",
-- 	peach = "#ef9f76",
-- 	yellow = "#e5c890",
-- 	green = "#a6d189",
-- 	teal = "#81c8be",
-- 	sky = "#99d1db",
-- 	sapphire = "#85c1dc",
-- 	blue = "#8caaee",
-- 	lavender = "#babbf1",
-- 	text = "#c6d0f5",
-- 	subtext1 = "#b5bfe2",
-- 	subtext0 = "#a5adce",
-- 	overlay2 = "#949cbb",
-- 	overlay1 = "#838ba7",
-- 	overlay0 = "#737994",
-- 	surface2 = "#626880",
-- 	surface1 = "#51576d",
-- 	surface0 = "#414559",
-- 	base = "#303446",
-- 	mantle = "#292c3c",
-- 	crust = "#232634",

return {
	'catppuccin/nvim',
	name = 'catppuccin',
	priority = 1000,
	config = function()
		require('catppuccin').setup {
			flavour = 'frappe', -- latte, frappe, macchiato, mocha
			transparent_background = true,
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { 'italic' }, -- Change the style of comments
				conditionals = { 'italic' },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {
				all = {
					green = '#81c8be',
                    -- mauve = '#c4a7e7',
                    -- yellow = '#f6c177',
                    red = '#eb6f92',
                    blue = '#a3b8ef',
				},
			},
			custom_highlights = function(colors)
				return {
                    ['@text'] = { fg = colors.surface0 },
					MiniCursorword = { underline = false, link = 'Visual' },
					MiniCursorwordCurrent = { link = 'MiniCursorword' },
					FloatBorder = { fg = colors.base },
					FzfLuaBorder = { link = 'FloatBorder' },
                    NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
                    IndentBlanklineChar = { fg = colors.base },
					FzfLuaTitle = { bg = colors.green, fg = colors.base, bold = false },
					FzfLuaHeaderText = { fg = colors.sky },
                    TreeSitterContextBottom = { underline = false, bg = colors.crust },
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				noice = true,
				treesitter_context = true,
				hop = true,
				mini = {
					enabled = true,
					indentscope_color = '',
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { 'italic' },
						hints = { 'italic' },
						warnings = { 'italic' },
						information = { 'italic' },
					},
					underlines = {
						errors = { 'undercurl' },
						hints = { 'undercurl' },
						warnings = { 'undercurl' },
						information = { 'undercurl' },
					},
				},
			},
		}

		vim.cmd.colorscheme 'catppuccin'
	end,
}
