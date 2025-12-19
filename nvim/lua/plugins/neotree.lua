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
			'<leader>fe',
			function()
				require('neo-tree.command').execute {
					action = 'focus',
					source = 'filesystem',
					reveal_force_cwd = true,
					position = 'left',
				}
			end,
		},
		-- Still experimental
		-- {
		-- 	'<leader>fw',
		-- 	function()
		-- 		opened_symbols = not opened_symbols
		--
		-- 		require('neo-tree.command').execute {
		-- 			action = opened_symbols and 'focus' or 'close',
		-- 			source = 'document_symbols',
		-- 			position = 'left',
		-- 		}
		-- 	end,
		-- },
	},
	config = function()
		local tree = require 'neo-tree'
		local fs_cmds = require 'neo-tree.sources.filesystem.commands'
		local fs = require 'neo-tree.sources.filesystem'
		local ui = require 'neo-tree.ui.renderer'

		tree.setup {
			sources = {
				'filesystem',
				'buffers',
				'git_status',
				'document_symbols',
			},

			popup_border_style = '',

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

			document_symbols = {
				follow_cursor = true,
				client_filters = 'first',
				renderers = {
					root = {
						{ 'indent' },
						{ 'icon', default = 'C' },
						{ 'name', zindex = 10 },
					},
					symbol = {
						{ 'indent', with_expanders = true },
						{ 'kind_icon', default = '?' },
						{
							'container',
							content = {
								{ 'name', zindex = 10 },
								{ 'kind_name', zindex = 20, align = 'right' },
							},
						},
					},
				},
			},

			window = {
				position = 'left',
				width = 48,
				popup = {
					size = {
						width = 120,
						height = '70%',
					},
				},
				mappings = {
					['/'] = 'noop',
					['f'] = 'filter_on_submit',
					['F'] = 'clear_filter',
					['S'] = 'open_split',
					['<esc>'] = 'revert_preview',
					['h'] = function(state)
						local node = state.tree:get_node()
						local parent_node = state.tree:get_node(node:get_parent_id())

						if parent_node:is_expanded() then
							ui.focus_node(state, node:get_parent_id())
							fs.toggle_directory(state, parent_node, nil, nil, nil, function()
								local pn = state.tree:get_node(state.tree:get_node():get_parent_id())

								if not pn:is_expanded() then
									fs_cmds.navigate_up(state)
								end
							end)
						end
					end,
					['w'] = 'open_split',
					['<C-v>'] = 'open_vsplit',
					['l'] = function(state)
						local node = state.tree:get_node()

						if node.type ~= 'directory' then
							fs_cmds.open(state)
							return
						end

						local cb = function()
							local ids = node:get_child_ids()
							ui.focus_node(state, ids[1])
						end

						if node.loaded then
							fs.toggle_directory(state, node)
							cb()
						else
							fs.toggle_directory(state, node, nil, nil, nil, cb)
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
					hide_gitignored = true,
					hide_hidden = false,
					hide_dotfiles = false,
					-- hide_by_name = { -- uses glob style patterns
					-- 	'node_modules',
					-- 	'coverage',
					-- 	'dist',
					-- },
				},

				find_args = { -- you can specify extra args to pass to the find command.
					fd = {
						'--exclude',
						'node_modules',
						'--exclude',
						'coverage',
						'--exclude',
						'dist',
					},
				},

				follow_current_file = {
					enabled = true,
				},
			},
		}
	end,
}
