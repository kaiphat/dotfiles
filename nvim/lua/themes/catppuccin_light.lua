return {
	'catppuccin/nvim',
	name = 'catppuccin',
	priority = 1000,
	config = function()
		require('catppuccin').setup {
            flavour = 'latte', -- latte, frappe, macchiato, mocha
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
					-- green = '#81c8be',
				},
			},
			custom_highlights = function(colors)
				return {
					MiniCursorword = { underline = false, link = 'Visual' },
					MiniCursorwordCurrent = { link = 'MiniCursorword' },
					FloatBorder = { fg = colors.overlay1 },
					FzfLuaBorder = { link = 'FloatBorder' },
					FzfLuaTitle = { bg = colors.green, fg = colors.base, bold = false },
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
