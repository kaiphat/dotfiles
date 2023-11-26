return {
	{
		'Exafunction/codeium.nvim',
		enabled = false,
		evant = { 'InsertEnter' },
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp',
		},
		config = function() require('codeium').setup {} end,
	},

	{
		'Exafunction/codeium.vim',
		enabled = true,
		event = 'InsertEnter',
		keys = {
			{ '<C-g>', function() return vim.fn['codeium#Accept']() end, mode = 'i', expr = true, silent = true },
			{
				'<C-q>',
				function() return vim.fn['codeium#CycleCompletions'](1) end,
				mode = 'i',
				expr = true,
				silent = true,
			},
		},
	},
}
