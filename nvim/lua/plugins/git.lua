__.add_plugin {
	'sindrets/diffview.nvim',
	keys = {
		{
			'<leader>gd',
			function()
				vim.cmd 'DiffviewOpen'
			end,
			desc = 'Open Diffview',
		},
		{
			'<leader>gp',
			function()
				vim.cmd 'DiffviewOpen HEAD~1'
			end,
			desc = 'Open Diffview for previous commit',
		},
		{
			'<leader>gc',
			function()
				vim.cmd 'DiffviewClose'
			end,
			desc = 'Close Diffview',
		},
		{
			'<leader>gf',
			function()
				vim.cmd 'DiffviewFileHistory'
			end,
			desc = 'Open Diffview file history for current file',
		},
		{
			'<leader>gm',
			function()
				vim.cmd 'DiffviewOpen origin/master...HEAD --imply-local'
			end,
			desc = 'Open Diffview for changes with master',
		},
	},
	opts = {
		hooks = {
			diff_buf_read = function(bufnr)
				vim.api.nvim_create_autocmd({ 'VimResized', 'WinEnter' }, {
					group = __.utils.create_augroup 'resize_pane',
					buffer = bufnr,
					callback = function()
						vim.cmd 'wincmd ='
					end,
				})
				vim.opt_local.wrap = true
			end,
			view_opened = function()
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
	},
}

__.add_plugin {
	'esmuellert/codediff.nvim',
	enabled = false,
	deps = { 'nui' },
	cmds = { 'CodeDiff' },
}
