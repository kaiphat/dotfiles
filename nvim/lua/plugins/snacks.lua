return {
	'folke/snacks.nvim',
	priority = 1000,
	lazy = false,
	enabled = true,
	keys = {
		-- lazygit
		{
			'<leader>lg',
			function()
				Snacks.lazygit()
			end,
		},
		{
			'<leader>gf',
			function()
				Snacks.lazygit.log_file()
			end,
		},

		-- picker
		{
			'<leader>fj',
			function()
				Snacks.picker.files {
					exclude = {
						'/test',
					},
				}
			end,
		},
		{
			'<leader>fJ',
			function()
				Snacks.picker.files {
					cwd = kaiphat.utils.get_current_dir(),
					ignored = true,
					hidden = true,
				}
			end,
		},
		{
			'<leader>es',
			function()
				Snacks.picker.files {
					cwd = '~/dotfiles',
				}
			end,
		},
		{
			'<leader>dj',
			function()
				Snacks.picker.files {}
			end,
		},
		{
			'<leader>dJ',
			function()
				Snacks.picker.files {
					ignored = true,
					hidden = true,
				}
			end,
		},

		{
			'<leader>fl',
			function()
				Snacks.picker.grep {
					exclude = {
						'/test',
					},
				}
			end,
		},
		{
			'<leader>dl',
			function()
				Snacks.picker.grep {}
			end,
		},
		{
			'<leader>fL',
			function()
				Snacks.picker.grep {
					cwd = kaiphat.utils.get_current_dir(),
				}
			end,
		},
		{
			'<leader>dL',
			function()
				Snacks.picker.grep {}
			end,
		},
		{
			'<leader>fp',
			function()
				Snacks.picker.resume {}
			end,
		},
		{
			'<leader>fo',
			function()
				Snacks.picker.recent {}
			end,
		},
		{
			'<leader>fb',
			function()
				Snacks.picker.buffers {}
			end,
		},
		{
			'<leader>fg',
			function()
				Snacks.picker.git_status {}
			end,
		},
		{
			'<leader>fh',
			function()
				Snacks.picker.grep_word {
					exclude = {
						'/test',
					},
				}
			end,
		},
		{
			'<leader>dh',
			function()
				Snacks.picker.grep_word {}
			end,
		},
		{
			'<leader>fi',
			function()
				Snacks.picker.lsp_references {
					include_declaration = false,
					pattern = '!import !test/ ',
				}
			end,
		},
		{
			'<leader>di',
			function()
				Snacks.picker.lsp_references {
					include_declaration = false,
				}
			end,
		},
		{
			'<leader>fw',
			function()
				Snacks.picker.lsp_workspace_symbols {}
			end,
		},
	},
	opts = {
		lazygit = {
			win = {
				style = 'lazygit',
			},
			config = {
				os = nil,
			},
		},

		picker = {
			prompt = kaiphat.constants.icons.BRACKET .. ' ',
			ui_select = true,
			formatters = {
				file = {
					filename_first = true, -- display filename before the file path
				},
			},
			layout = {
				layout = {
					box = 'vertical',
					backdrop = false,
					row = -1,
					width = 0,
					height = 0.4,
					border = 'top',
					title = ' {source} {live} {flags}',
					title_pos = 'left',
					{ win = 'input', height = 1, border = 'bottom' },
					{
						box = 'horizontal',
						{ win = 'list', border = 'none' },
						{ win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
					},
				},
			},
			win = {
				input = {
					keys = {
						['<c-e>'] = { 'close', mode = 'i' },
						['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
						['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
					},
				},
				preview = {},
			},
			previewers = {
				git = {
					native = true, -- use native (terminal) or Neovim for previewing git diffs and commits
				},
			},
		},

		indent = {
			indent = {
				enabled = true,
				char = kaiphat.constants.icons.VERTICAL_LINE_1,
			},
			animate = {
				enabled = false,
			},

			scope = {
				enabled = false,
			},
		},

		words = {
			enabled = true,
		},
	},
}
