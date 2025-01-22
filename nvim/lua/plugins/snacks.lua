local grep_always_excludes = {
	'.git/',
	'dist/',
	'node_modules/',
	'build/',
	'docker_volumes_data/',
	'yarn.lock',
	'Cargo.lock',
	'coverage/',
	'package-lock.json',
}

local grep_exclude = kaiphat.utils.merge(grep_always_excludes, {
	'data/',
	'.data/',
	'test/',
	'tests/',
	'**/__tests__/*',
	'**/__mocks__/*',
	'*.log',
	'.gitignore',
	'*.md',
	'*.json',
})

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
					ignored = true,
					hidden = true,
					cwd = '~/dotfiles',
				}
			end,
		},
		{
			'<leader>en',
			function()
				Snacks.picker.files {
					ignored = true,
					hidden = true,
					cwd = '~/notes',
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
					exclude = grep_exclude,
				}
			end,
		},
		{
			'<leader>dl',
			function()
				Snacks.picker.grep {
					exclude = grep_always_excludes,
				}
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
				Snacks.picker.grep()
			end,
		},
		{
			'<leader>fp',
			function()
				Snacks.picker.resume()
			end,
		},
		{
			'<leader>fo',
			function()
				Snacks.picker.recent {
					sort = {
						fields = { 'idx' },
					},
				}
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
					exclude = grep_exclude,
				}
			end,
		},
		{
			'<leader>dh',
			function()
				Snacks.picker.grep_word {
					exclude = grep_always_excludes,
				}
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
		{
			'<leader>fm',
			function()
				Snacks.picker.help()
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
			prompt = ' ' .. kaiphat.constants.icons.BRACKET .. ' ',
			ui_select = true,
			formatters = {
				file = {
					filename_first = true, -- display filename before the file path
				},
			},
			layout = {
				layout = {
					backdrop = false,
					width = function()
						local c = vim.o.columns
						if c > 160 then
							return 0.7
						else
							return 0.9
						end
					end,
					min_width = 80,
					height = 0.8,
					min_height = 30,
					box = 'vertical',
					border = 'rounded',
					title = '{title} {live} {flags}',
					title_pos = 'center',
					{ win = 'input', height = 2, border = 'none' },
					{ win = 'list', height = 15, border = 'none' },
					{ win = 'preview', border = 'top' },
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
				preview = {
					wo = {
						number = false,
						relativenumber = false,
						signcolumn = 'no',
						foldcolumn = '1',
						foldenable = false,
					},
				},
			},
			previewers = {
				git = {
					native = false, -- use native (terminal) or Neovim for previewing git diffs and commits
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
			enabled = false,
			debounce = 400,
		},

		quickfile = {},
		bigfile = {},
	},
}
