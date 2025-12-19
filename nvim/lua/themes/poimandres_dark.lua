local palette = {
	yellow = '#FFFAC2',
	teal1 = '#5DE4C7',
	teal2 = '#5FB3A1',
	teal3 = '#42675A',
	blue1 = '#89DDFF',
	blue2 = '#ADD7FF',
	blue3 = '#91B4D5',
	blue4 = '#7390AA',
	pink1 = '#FAE4FC',
	pink2 = '#FCC5E9',
	pink3 = '#D0679D',
	blueGray1 = '#A6ACCD',
	blueGray2 = '#767C9D',
	blueGray3 = '#506477',
	background1 = '#303340',
	background2 = '#1B1E28',
	background3 = '#171922',
	background4 = '#384155',
	text = '#E4F0FB',
	white = '#FFFFFF',
	none = 'NONE',
}

return {
	'olivercederborg/poimandres.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('poimandres').setup {
			disable_background = true,
			disable_float_background = true,
		}

		vim.cmd 'colorscheme poimandres'

		vim.api.nvim_set_hl(0, 'WinSeparator', { fg = palette.blueGray2 })
		vim.api.nvim_set_hl(0, 'Folded', { fg = palette.blueGray2, bg = nil })
		vim.api.nvim_set_hl(0, 'FloatBorder', { fg = palette.blueGray2 })
		vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = palette.background4, underline = false })
		vim.api.nvim_set_hl(0, 'Keyword', { fg = palette.teal1 })
		vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = palette.blueGray2 })
		vim.api.nvim_set_hl(0, 'ColorColumn', { bg = nil })
		vim.api.nvim_set_hl(0, 'SnacksPickerMatch', { fg = palette.teal1 })

		vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = palette.background1 })
		vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = palette.background1 })
		vim.api.nvim_set_hl(0, 'TreesitterContextSeparator', { bg = palette.background1 })

		vim.api.nvim_set_hl(0, 'FlashLabel', { bg = palette.background4, fg = palette.teal1 })
		vim.api.nvim_set_hl(0, 'Function', { fg = '#8fb1cc' })
		vim.api.nvim_set_hl(0, 'Normal', { fg = '#e0eefa' })
		vim.api.nvim_set_hl(0, 'Visual', { bg = palette.background4, fg = nil })
		vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = palette.blueGray2, bg = palette.background1 })

		vim.api.nvim_set_hl(0, 'DiffChange', { bg = palette.background4 })

		vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = palette.background4 })
		vim.api.nvim_set_hl(0, 'FylerIndentMarker', { fg = palette.background4 })
	end,
}

-- require('base16-colorscheme').setup({
--     base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',
--     base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
--     base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
--     base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
-- })
