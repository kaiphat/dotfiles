return {
	'nvim-neorg/neorg',
	event = { 'BufReadPre', 'BufNew *.norg' },
	build = ':Neorg sync-parsers',
	config = function()
		local neorg = require 'neorg'

		neorg.setup {
			load = {
				['core.defaults'] = {},
				['core.concealer'] = {},
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
			},
		}
	end,
}
