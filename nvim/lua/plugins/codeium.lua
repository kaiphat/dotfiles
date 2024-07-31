vim.g.codeium_idle_delay = 20
vim.g.codeium_disable_bindings = 1
vim.g.codeium_enabled = true

return {
	{
		'Exafunction/codeium.nvim',
		enabled = false,
		evant = { 'InsertEnter' },
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp',
		},
		config = function()
			require('codeium').setup {}
		end,
	},

	{
		'Exafunction/codeium.vim',
		enabled = true,
		event = 'BufEnter',
		keys = {
			{
				'<C-g>',
				function()
					return vim.fn['codeium#Accept']()
				end,
				mode = 'i',
				expr = true,
				silent = true,
			},
			{
				'<C-q>',
				function()
					return vim.fn['codeium#CycleCompletions'](1)
				end,
				mode = 'i',
				expr = true,
				silent = true,
			},
		},
	},
}
