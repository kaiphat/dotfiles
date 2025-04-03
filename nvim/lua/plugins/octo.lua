return {
	'pwntester/octo.nvim',
	cmd = { 'Octo' },
	dependencies = {
		'nvim-lua/plenary.nvim',
		'folke/snacks.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		require('octo').setup {
			picker = 'snacks',
		}
	end,
}
