return {
	'A7Lavinraj/fyler.nvim',
	dependencies = { 'nvim-mini/mini.icons' },
	branch = 'stable',
	enabled = false,
	keys = {
		{
			'<leader>o',
			function()
				require('fyler').open()
			end,
		},
		{
			'<leader><C-o>',
			function()
				require('fyler').open {
					dir = vim.fn.expand '%:p:h',
				}
			end,
		},
		{
			'<leader>O',
			function()
				require('fyler').open {
					dir = vim.uv.cwd(),
				}
			end,
		},
	},
	opts = {
		views = {
			finder = {
				delete_to_trash = true,
				indentscope = {
					enabled = true,
					group = 'FylerIndentMarker',
					marker = kaiphat.constants.icons.VERTICAL_LINE_1,
				},

				mappings = {
					['q'] = 'CloseView',
					['<C-l>'] = 'Select',
					['<C-t>'] = 'SelectTab',
					['|'] = 'SelectVSplit',
					['-'] = 'SelectSplit',
					['^'] = 'GotoParent',
					['='] = 'GotoCwd',
					['.'] = 'GotoNode',
					['#'] = 'CollapseAll',
					['<C-h>'] = function(self)
						local current_node = self:cursor_node_entry()
						local parent_ref_id = self.files:find_parent(current_node.ref_id)
						if not parent_ref_id then
							return
						end

						if self.files.trie.value == parent_ref_id then
							self:exec_action 'n_goto_parent'
						else
							self:exec_action 'n_collapse_node'
						end
					end,
					['<C-y>'] = function(self)
						local current_node = self:cursor_node_entry()
						local relpath = vim.fn.fnamemodify(current_node.path, ':.')

						vim.fn.setreg('+', relpath)
					end,
				},
			},
		},
	},
}
