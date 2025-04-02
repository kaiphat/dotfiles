return {
	'saghen/blink.cmp',
	enabled = true,
	lazy = false,
	version = '*',
	opts = {
		keymap = {
			['<C-j>'] = { 'show', 'select_next', 'fallback' },
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-x>'] = { 'hide' },
			['<C-o>'] = { 'select_and_accept' },
			['<C-e>'] = {},
			['<Tab>'] = {},
		},

		fuzzy = {
			implementation = 'rust',
			-- max_typos = function(keyword) return math.floor(#keyword / 4) end,
			max_typos = function()
				return 0
			end,
			use_frecency = true,
			use_proximity = true,
		},

		completion = {
			documentation = {
				window = {
					border = 'rounded',
				},
			},

			menu = {
				border = 'rounded',
			},

			accept = {
				auto_brackets = {
					enabled = false,
					semantic_token_resolution = {
						enabled = true,
						blocked_filetypes = {},
						-- How long to wait for semantic tokens to return before assuming no brackets should be added
						timeout_ms = 400,
					},
				},
			},

			ghost_text = {
				enabled = false,
			},
		},

		cmdline = {
			enabled = false,
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
			providers = {
				lsp = {
					name = 'LSP',
					module = 'blink.cmp.sources.lsp',
					enabled = true, -- whether or not to enable the provider
					transform_items = nil, -- function to transform the items before they're returned
					should_show_items = true, -- whether or not to show the items
					max_items = 100, -- maximum number of items to return
					min_keyword_length = 0,
					fallbacks = {}, -- if any of these providers return 0 items, it will fallback to this provider
					score_offset = 0, -- boost/penalize the score of the items
					override = nil, -- override the source's functions
					async = false,
				},
				path = {
					name = 'Path',
					module = 'blink.cmp.sources.path',
					score_offset = 0,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				snippets = {
					name = 'Snippets',
					module = 'blink.cmp.sources.snippets',
					score_offset = 1,
					min_keyword_length = 1,
					opts = {
						friendly_snippets = false,
						search_paths = { vim.fn.stdpath 'config' .. '/snippets' },
						global_snippets = { 'all' },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
					should_show_items = function(ctx)
						return ctx.trigger.initial_kind ~= 'trigger_character'
					end,
				},
				buffer = {
					name = 'Buffer',
					module = 'blink.cmp.sources.buffer',
					score_offset = -5,
					max_items = 20,
					min_keyword_length = 0,
					opts = {
						get_bufnrs = vim.api.nvim_list_bufs,
					},
				},
			},
		},
	},
}
