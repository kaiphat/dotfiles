__.add_plugin {
	'aerial',
	'stevearc/aerial.nvim',
	event = 'BufEnter',
	deps = {
		'nvim-treesitter',
	},
}

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
