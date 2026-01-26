return {
	'https://gitlab.com/motaz-shokry/gruvbox.nvim',
	name = 'gruvbox',
	priority = 1000,
	config = function()
		require('gruvbox').setup {
			variant = 'hard',

			enable = {
				terminal = true,
				migrations = true, -- Handle deprecated options automatically
				devicons = true, -- Theming devicons with gruvbox
				lualine = false,
			},

			styles = {
				bold = false,
				italic = false,
				transparency = true,
			},

			highlight_groups = {
				StatusLine = { bg = 'NONE' },
				StatusLineNC = { bg = 'NONE' },
				MiniCursorword = { link = 'Visual', underline = false, blend = 50 },
				MiniCursorwordCurrent = { link = 'MiniCursorword' },
			},
		}

		vim.o.background = 'dark' -- or "light" for light mode

		vim.cmd 'colorscheme gruvbox'
	end,
}
