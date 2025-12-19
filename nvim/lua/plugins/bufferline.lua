return {
	'akinsho/bufferline.nvim',
	version = '*',
	dependencies = 'nvim-tree/nvim-web-devicons',
	enabled = false,
	config = function()
		local bufferline = require 'bufferline'
		bufferline.setup {
			options = {
				style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
				themable = true,
				indicator = {
					icon = '▎', -- this should be omitted if indicator style is not 'icon'
				},
			},
		}
	end,
}
