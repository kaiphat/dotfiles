return {
	'mcchrish/zenbones.nvim',
	dependencies = { 'rktjmp/lush.nvim' },
	lazy = false,
	priority = 1000,
	config = function()
		local lush = require 'lush'
		local base = require 'nordbones'
		local palette = require 'nordbones.palette'

		vim.api.nvim_create_autocmd('ColorScheme', {
			pattern = 'zenbones',
			callback = function()
				local specs = lush.parse(function()
					return {
						MiniCursorword { bg = palette.dark.blossom },
						SnacksPicker { bg = 'NONE' },
						FloatBorder { base.FlotBorder, bg = 'NONE' },
						NormalFloat { bg = 'NONE' },
					}
				end)

				lush.apply(lush.compile(specs))
			end,
		})

		vim.opt.background = 'dark'
		vim.g.zenburned_transparent_background = true

		vim.cmd.colorscheme 'zenburned'
	end,
}
