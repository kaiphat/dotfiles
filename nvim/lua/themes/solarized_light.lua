return {
	'maxmx03/solarized.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = 'light'

		require('solarized').setup {
			palette = 'solarized',
			transparent = {
				enabled = true,
			},
			styles = {
				keywords = { italic = true },
				functions = { italic = true },
			},
		}

		vim.cmd.colorscheme 'solarized'
	end,
}
