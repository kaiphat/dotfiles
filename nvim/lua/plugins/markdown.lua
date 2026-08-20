__.add_plugin {
	'jakewvincent/mkdnflow.nvim',
	ft = { 'markdown' },
	opts = {
		to_do = {
			highlight = false,
			statuses = {
				not_started = { marker = ' ' },
				in_progress = { marker = '-' },
				complete = { marker = 'x' },
			},
			status_order = { 'not_started', 'in_progress', 'complete' },
			status_propagation = { up = true, down = true },
			sort = {
				on_status_change = true,
				recursive = true,
				cursor_behavior = { track = true },
			},
		},
		mappings = {
			MkdnToggleToDo = { { 'n', 'v' }, 'tt' }, -- Multiple modes
			MkdnCreateLinkFromClipboard = false,
		},
	},
}

__.add_plugin {
	'MeanderingProgrammer/render-markdown.nvim',
	ft = {
		'markdown',
	},
	deps = {
		'nvim-treesitter',
		'mini.icons',
	},
	load = function(_)
		vim.treesitter.language.register('markdown', 'copilot-chat')

		_.setup {
			file_types = { 'markdown', 'copilot-chat' },
			heading = {
				sign = false,
				icons = { '◇ ', '◇ ', '◇ ', '◇ ', '◇ ', '◇ ' },
			},
			code = {
				sign = false,
				style = 'full',
				width = 'full',
				border = 'thick',
				language = false,
				language_icon = false,
			},
			bullet = {
				icons = { '•', '◦', '■', '◇ ' },
			},
			completions = {
				lsp = {
					enabled = true,
				},
			},
			dash = {
				icon = '─',
			},
			checkbox = {
				-- unchecked = { icon = '✘ ' },
				-- checked = { icon = '✔ ' },
				-- custom = { todo = { rendered = '◯ ' } },
			},
		}
	end,
}
