return {
	'kevinhwang91/nvim-bqf',
	ft = 'qf',
	enabled = true,
	config = function()
		require('bqf').setup {}
	end,
}
