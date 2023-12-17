return {
	'ellisonleao/gruvbox.nvim',
	config = function()
		require('gruvbox').setup {
			underline = false,
			transparent_mode = true,
			overrides = {
                MiniCursorword = { underline = false, bg = '#ccccdd' }
			}
		}

		vim.cmd 'colorscheme gruvbox'
	end,
}
