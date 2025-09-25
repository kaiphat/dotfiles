return {
	'everviolet/nvim',
	name = 'evergarden',
	priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
	config = function()
		require('evergarden').setup {
			theme = {
				variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
				accent = 'green',
			},
			editor = {
				transparent_background = true,
				sign = { color = 'none' },
				float = {
					color = 'mantle',
					solid_border = false,
				},
				completion = {
					color = 'surface0',
				},
			},
		}
		vim.cmd.colorscheme 'evergarden'
	end,
}
