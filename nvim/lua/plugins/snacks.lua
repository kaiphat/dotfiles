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
				preview = true,
				layout = {
					backdrop = false,
					width = 0.4,
					min_width = 80,
					height = 0.8,
					border = 'none',
					box = 'vertical',
					{ win = 'input', height = 1, border = 'rounded', title = '{source} {live}', title_pos = 'center' },
					{ win = 'list', border = 'hpad', height = 6 },
					{ win = 'preview', border = 'rounded' },
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
	},
}
