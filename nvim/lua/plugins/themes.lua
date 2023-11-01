local themes = {
	DARK = {
		dir = '../themes/dark_theme.lua',
		priority = 1000,
		config = function() require 'themes.dark_theme' end,
	},

	NEW_DARK = {
		priority = 1000,
		dir = '../themes/new_dark_theme.lua',
		config = function() require 'themes.new_dark_theme' end,
	},

	GITHUB_LIGHT = {
		'projekt0n/github-nvim-theme',
		priority = 1000,
		config = function()
			require('github-theme').setup {}

			vim.cmd 'colorscheme github_light_high_contrast'
		end,
	},

	ROSE_PINE_LIGHT = {
		'rose-pine/neovim',
		priority = 1000,
		name = 'rose-pine',
		config = function()
			require('rose-pine').setup {}

			vim.cmd 'colorscheme rose-pine-dawn'
		end,
	},
}

return { themes.DARK }
