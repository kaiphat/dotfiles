return {
	{
		'sindrets/diffview.nvim',
		keys = {
			{
				'<leader>gd',
				'<cmd>DiffviewOpen<cr>',
				desc = 'Open Diffview',
			},
			{
				'<leader>gp',
				'<cmd>DiffviewOpen HEAD~1<cr>',
				desc = 'Open Diffview for previous commit',
			},
			{
				'<leader>gc',
				'<cmd>DiffviewClose<cr>',
				desc = 'Close Diffview',
			},
			{
				'<leader>gf',
				'<cmd>DiffviewFileHistory %<cr>',
				desc = 'Open Diffview file history for current file',
			},
			{
				'<leader>gm',
				'<cmd>DiffviewOpen origin/master...HEAD --imply-local<cr>',
				desc = 'Open Diffview for changes with master',
			},
		},
		config = function()
			require('diffview').setup {
				hooks = {
					diff_buf_read = function(bufnr)
						vim.api.nvim_create_autocmd({ 'VimResized', 'WinEnter' }, {
							group = kaiphat.utils.create_augroup 'resize_pane',
							buffer = bufnr,
							callback = function(event)
								vim.cmd 'wincmd ='
							end,
						})
						vim.opt_local.wrap = true
					end,
					view_opened = function(view)
						-- vim.cmd ':WindowsDisableAutowidth'
					end,
				},

				file_panel = {
					listing_style = 'tree', -- One of 'list' or 'tree'
					tree_options = { -- Only applies when listing_style is 'tree'
						flatten_dirs = true, -- Flatten dirs that only contain one single dir
						folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
					},
					win_config = { -- See |diffview-config-win_config|
						position = 'left',
						width = 40,
						win_opts = {},
					},
				},
			}
		end,
	},
}
