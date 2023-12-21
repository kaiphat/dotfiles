return {
	{ 'nvim-lua/plenary.nvim', lazy = true },
	{ 'nvim-lua/popup.nvim', lazy = true },
	{
		'kyazdani42/nvim-web-devicons',
		lazy = true,
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
	{ 'MunifTanjim/nui.nvim', lazy = true },
}
