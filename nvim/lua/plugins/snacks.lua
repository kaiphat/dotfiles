return {
	'folke/snacks.nvim',
	enabled = true,
	keys = {
		{
			'<leader>lg',
			function()
				Snacks.lazygit()
			end,
		},
		{
			'<leader>gf',
			function()
				Snacks.lazygit.log_file()
			end,
		},
	},
	opts = {
		lazygit = {
			win = {
				style = 'lazygit',
			},
			config = {
				os = nil,
			},
		},
	},
}
