return {
	'nvim-pack/nvim-spectre',
	keys = {
		{
			'<leader>r',
			function()
				require('spectre').toggle()
			end,
		},
	},
	config = function()
		require('spectre').setup()
	end,
}
