return {
	'maxmx03/solarized.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = 'light' -- or 'light'

		require('solarized').setup {
			transparent = true,
		}

		vim.cmd.colorscheme 'solarized'
	end,
}
