return {
	'Exafunction/codeium.vim',
	event = 'InsertEnter',
	keys = {
		{ '<C-g>', function() return vim.fn['codeium#Accept']() end, mode = 'i', expr = true, silent = true },
        { '<C-q>', function() return vim.fn['codeium#CycleCompletions'](1) end, mode = 'i', expr = true, silent = true },
	},
}
