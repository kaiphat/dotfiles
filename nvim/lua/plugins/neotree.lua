local root_path = kaiphat.utils.get_full_path()

return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v3.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',
	},
	lazy = true,
	enabled = true,
	keys = {
		{
			'<leader>e',
			function()
				require('neo-tree.command').execute {
					source = 'filesystem',
					dir = kaiphat.utils.get_current_dir(),
					reveal_force_cwd = true,
					reveal_file = kaiphat.utils.get_full_path(),
				}
			end,
		},
		-- {
		-- 	'<leader>O',
		-- 	function()
		-- 		require('neo-tree.command').execute {
		-- 			source = 'filesystem',
		-- 			dir = root_path,
		-- 		}
		-- 	end,
		-- },
		{
			'<leader><C-o>',
			function()
				require('neo-tree.command').execute {
					source = 'git_status',
				}
			end,
		},
	},
	config = function()
		local tree = require 'neo-tree'
		local fs_cmds = require 'neo-tree.sources.filesystem.commands'
		local fs = require 'neo-tree.sources.filesystem'
		local ui = require 'neo-tree.ui.renderer'

		tree.setup {
			popup_border_style = 'rounded',

			default_component_configs = {
				git_status = {
					symbols = {
						unstaged = '',
					},
				},
				type = {
					enabled = false,
				},
				created = {
					enabled = false,
				},
				last_modified = {
					enabled = false,
				},
			},
			window = {
				position = 'float',
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				popup = {
					size = {
						width = 120,
						height = '70%',
					},
				},
				mappings = {
					['/'] = 'noop',
					['f'] = 'filter_on_submit',
					['S'] = 'open_split',
					['<esc>'] = 'revert_preview',
					['h'] = function(state)
						local node = state.tree:get_node()
						local parent_node = state.tree:get_node(node:get_parent_id())
						if parent_node:is_expanded() then
							ui.focus_node(state, node:get_parent_id())
							fs.toggle_directory(state, parent_node)

							local pn = state.tree:get_node(state.tree:get_node():get_parent_id())

							if not pn:is_expanded() then
								fs_cmds.navigate_up(state)
							end
						end
					end,
					['w'] = 'open_split',
					['l'] = function(state)
						local node = state.tree:get_node()

						if node.type == 'directory' then
							fs.toggle_directory(state, node, nil, nil, nil, function()
								local ids = node:get_child_ids()
								ui.focus_node(state, ids[1])
							end)
						else
							fs_cmds.open(state)
						end
					end,
					['L'] = function(state)
						fs_cmds.navigate_down(state)
					end,
					['u'] = function(state)
						fs_cmds.navigate_up(state)
					end,
					['i'] = function(state)
						fs_cmds.set_root(state)
					end,
					['P'] = { 'toggle_preview', config = { use_float = true } },
					['t'] = 'open_tabnew',
					['C'] = 'close_node',
					['z'] = 'close_all_nodes',
					['a'] = {
						'add',
						config = {
							show_path = 'none', -- 'none', 'relative', 'absolute'
						},
					},
					['A'] = 'add_directory',
					['d'] = 'delete',
					['r'] = 'rename',
					['y'] = 'copy_to_clipboard',
					['x'] = 'cut_to_clipboard',
					['p'] = 'paste_from_clipboard',
					['c'] = 'copy',
					['m'] = 'move',
					['q'] = 'close_window',
					['<C-e>'] = 'close_window',
					['<C-c>'] = 'close_window',
					['R'] = 'refresh',
					['?'] = 'show_help',
					['<'] = 'prev_source',
					['>'] = 'next_source',
				},
			},
			buffers = {
				bind_to_cwd = false,
			},
			filesystem = {
				bind_to_cwd = false,
				filtered_items = {
					hide_gitignored = false,
					hide_hidden = false,
					hide_dotfiles = false,
				},
			},
		}
	end,
}
