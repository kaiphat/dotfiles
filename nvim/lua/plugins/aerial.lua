__.add_plugin {
	'stevearc/aerial.nvim',
	event = 'BufReadPost',
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
}
