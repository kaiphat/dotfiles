__.add_plugin {
	'stevearc/aerial.nvim',
	event = 'BufEnter',
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
