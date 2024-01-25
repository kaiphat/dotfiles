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
			disable_float_background = true
		}

		vim.cmd 'colorscheme poimandres'

        vim.api.nvim_set_hl(0, 'VertSplit', { fg = palette.blueGray3 })
        vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = palette.background4, underline = false })
	end,
}
