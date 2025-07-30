local languages = {
	'javascript',
	'rust',
	'typescript',
	'toml',
	'yaml',
	'vim',
	'tsx',
	'markdown',
	'json',
	'jsdoc',
	'lua',
	'make',
	'css',
	'html',
	'scss',
	'dockerfile',
	'fish',
	'glimmer',
	'scheme',
	'sql',
	'python',
	'bash',
	'regex',
	'kdl',
	'proto',
	'markdown_inline',
	'nu',
	'graphql',
}

return {
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = 'BufReadPre',
		enabled = true,
		keys = {
			{
				'[c',
				function()
					require('treesitter-context').go_to_context()
				end,
			},
		},
		opts = {
			max_lines = 2,
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		version = false,
		event = 'VeryLazy',
		build = ':TSUpdate',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			local install = require 'nvim-treesitter.install'
			local config = require 'nvim-treesitter.configs'

			install.compilers = { 'gcc' }

			config.setup {
				fold = {
					enabled = true,
				},
				ensure_installed = languages,
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { 'BufWrite', 'CursorHold' },
				},
				autotag = {
					enable = true,
				},
				endwise = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = false,
						keymaps = {
							['if'] = '@function.inner',
						},
					},
					move = {
						enable = true,
						goto_next_start = {
							[']f'] = '@function.outer',
						},
						goto_previous_start = {
							['[f'] = '@function.outer',
						},
					},
				},
				highlight = {
					enable = true,
					use_languagetree = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = {},
				},
				incremental_selection = {
					enable = false,
					keymaps = {
						init_selection = '<C-space>',
						node_incremental = '<C-space>',
						node_decremental = '<BS>',
					},
				},
			}
		end,
	},
}
