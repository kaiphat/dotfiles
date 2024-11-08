return {
	'saghen/blink.cmp',
	enabled = true,
	lazy = false,
	build = 'cargo build --release',
	opts = {
		accept = {
			auto_brackets = {
				enabled = true,
				semantic_token_resolution = {
					enabled = true,
					blocked_filetypes = {},
					-- How long to wait for semantic tokens to return before assuming no brackets should be added
					timeout_ms = 400,
				},
			},
		},

		highlight = {
			use_nvim_cmp_as_default = true,
		},

		nerd_font_variant = 'normal',

		keymap = {
			['<C-j>'] = { 'show', 'select_next', 'fallback' },
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-x>'] = { 'hide' },
			['<C-o>'] = { 'select_and_accept' },
		},

		windows = {
			autocomplete = {
				border = 'rounded',
				draw = 'simple', -- simple | reversed | minimal
				-- selection = 'auto_insert',
			},
			documentation = {
				auto_show = true,
				border = 'rounded',
			},
		},

		fuzzy = {
			use_typo_resistance = true,
			use_frecency = true,
			use_proximity = true,
			max_items = 50,
			sorts = { 'label', 'kind', 'score' },
		},

		sources = {
			providers = {
				lsp = {
					name = 'LSP',
					module = 'blink.cmp.sources.lsp',
					enabled = true, -- whether or not to enable the provider
					transform_items = nil, -- function to transform the items before they're returned
					should_show_items = true, -- whether or not to show the items
					max_items = nil, -- maximum number of items to return
					min_keyword_length = 0, -- minimum number of characters to trigger the provider
					fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
					score_offset = 0, -- boost/penalize the score of the items
					override = nil, -- override the source's functions
				},
				path = {
					name = 'Path',
					module = 'blink.cmp.sources.path',
					score_offset = 3,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					name = 'Snippets',
					module = 'blink.cmp.sources.snippets',
					score_offset = -1,
					opts = {
						friendly_snippets = false,
						search_paths = { vim.fn.stdpath 'config' .. '/snippets' },
						global_snippets = { 'all' },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
				},
				buffer = {
					name = 'Buffer',
					module = 'blink.cmp.sources.buffer',
					fallback_for = { 'lsp' },
				},
			},
		},

		trigger = {
			completion = {
				show_in_snippet = true,
			},
		},

		kind_icons = {
			Text = '󰉿',
			Method = '',
			Function = '󰊕',
			Constructor = '󰒓',

			Field = '󰜢',
			Variable = '󰆦',
			Property = '󰖷',

			Class = '',
			Interface = '󱡠',
			Struct = '󱡠',
			Module = '󰅩',

			Unit = '󰪚',
			Value = '󰦨',
			Enum = '󰦨',
			EnumMember = '󰦨',

			Keyword = '󰻾',
			Constant = '󰏿',

			Snippet = '󱄽',
			Color = '󰏘',
			File = '󰈔',
			Reference = '󰬲',
			Folder = '󰉋',
			Event = '󱐋',
			Operator = '󰪚',
			TypeParameter = '󰬛',
		},
	},
}
