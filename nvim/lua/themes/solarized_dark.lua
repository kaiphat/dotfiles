return {
	'maxmx03/solarized.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = 'dark' -- or 'light'

		require('solarized').setup {
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
