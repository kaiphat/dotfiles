return {
	'ellisonleao/gruvbox.nvim',
	priority = 1000,
	config = function()
		require('gruvbox').setup {
			underline = false,
			transparent_mode = true,
			overrides = {
                MiniCursorword = { underline = false, bg = '#ccccdd' }
			}
		}

        vim.o.background = "light" -- or "light" for light mode
		vim.cmd 'colorscheme gruvbox'
	end,
}
