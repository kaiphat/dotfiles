return {
	'stevearc/aerial.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		require('aerial').setup {
			layout = {
				max_width = { 70, 0.3 },
				width = 40,
				min_width = 10,
				placement = 'editor',
				default_direction = 'left',
			},
			attach_mode = 'global',
		}

		vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
	end,
}
