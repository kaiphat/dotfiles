__.add_plugin {
	'stevearc/aerial.nvim',
	event = 'BufReadPost',
	enabled = false,
	deps = {
		'nvim-treesitter',
	},
	keys = {
		{
			'<leader>a',
			function()
				vim.cmd 'AerialToggle'
			end,
		},
	},
	opts = {
		disable_max_lines = 20000,
	},
}
