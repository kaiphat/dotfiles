return {
	'mcchrish/zenbones.nvim',
	dependencies = { 'rktjmp/lush.nvim' },
	config = function()
		local lush = require 'lush'
		local base = require 'nordbones'
        local palette = require 'nordbones.palette'

		local specs = lush.parse(function()
			return {
				MiniCursorword { bg = palette.dark.blossom },
                FloatBorder = { base.FlotBorder, bg = 'NONE' },
                NormalFloat = { bg = 'NONE' },
			}
		end)

		lush.apply(lush.compile(specs))

		vim.opt.background = 'dark'
		vim.g.nordbones_transparent_background = true

		vim.cmd.colorscheme 'nordbones'
	end,
}
