return {
	'nvim-neorg/neorg',
	ft = 'norg',
	event = 'BufNew *.norg',
	enabled = false,
	build = ':Neorg sync-parsers',
	config = function()
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('set_number', {}),
			pattern = 'norg',
			callback = function()
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.wrap = true
			end,
		})

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
			group = vim.api.nvim_create_augroup('autosave', {}),
			pattern = '*.norg',
			callback = function()
				vim.cmd 'silent! write'
			end,
		})

		require('neorg').setup {
			load = {
				['core.defaults'] = {},
				['core.concealer'] = {
					config = {
						folds = true,
					},
				},
				['core.dirman'] = {
					config = {
						workspaces = {
							main = '~/notes',
						},
					},
				},
				['core.keybinds'] = {
					config = {
						hook = function(keybinds)
							keybinds.remap_event('norg', 'n', 'gd', 'core.qol.todo_items.todo.task_done')
							keybinds.remap_event('norg', 'n', 'gu', 'core.qol.todo_items.todo.task_undone')
						end,
						default_keybinds = true,
					},
				},
				['core.completion'] = {
					config = {
						engine = 'nvim-cmp',
					},
				},
			},
		}
	end,
}
