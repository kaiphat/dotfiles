return {
	{
		'nvim-lua/plenary.nvim',
		event = 'VeryLazy',
	},
	{
		'nvim-lua/popup.nvim',
		event = 'VeryLazy',
	},
	{
		'kyazdani42/nvim-web-devicons',
		event = 'VeryLazy',
		config = function()
			require('nvim-web-devicons').setup {
				override = {
					['toml'] = {
						icon = '󱈤',
						color = '#a3b8ef',
						cterm_color = '231',
						name = 'Toml',
					},
					['norg'] = {
						icon = '󱈤',
						color = '#a3b8ef',
						cterm_color = '231',
						name = 'Toml',
					},
				},
			}
		end,
	},
}
