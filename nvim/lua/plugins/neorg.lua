return {
	'nvim-neorg/neorg',
	ft = 'norg',
	event = { 'BufReadPre', 'BufNew *.norg' },
	build = ':Neorg sync-parsers',
	config = function()
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
