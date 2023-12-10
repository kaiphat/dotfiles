local M = {}

M.languages = {
	'javascript',
	'rust',
	'typescript',
	'toml',
	'yaml',
	'vim',
	'tsx',
	'markdown',
	'json',
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
	'norg',
	'kdl',
	'proto',
	'markdown_inline',
	'nu',
	'graphql',
}

M.add_mixins = function()
	-- vim.treesitter.language.register('fish', 'nu')
end

return {
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = 'BufReadPre',
		enabled = false,
		keys = {
			{ '[c', function() require('treesitter-context').go_to_context() end },
		},
		opts = {
			max_lines = 4,
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		version = false,
		lazy = false,
		build = ':TSUpdate',
		keys = {
			{ 'u', function() require('utils.unit').select(true) end, mode = { 'x', 'o' } },
		},
		config = function()
			local install = require 'nvim-treesitter.install'
			local config = require 'nvim-treesitter.configs'
			local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

			install.compilers = { 'gcc' }

			parser_config.nu = {
				install_info = {
					url = 'https://github.com/nushell/tree-sitter-nu',
					files = { 'src/parser.c' },
					branch = 'main',
				},
				filetype = 'nu',
			}

			config.setup {
				ensure_installed = M.languages,
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
				textsubjects = {
					enable = true,
					keymaps = {
						['.'] = 'textsubjects-smart',
						[';'] = 'textsubjects-container-outer',
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
					enable = true,
					keymaps = {
						init_selection = '<Enter>',
						node_incremental = '<Enter>',
						node_decremental = '<BS>',
					},
				},
			}

			M.add_mixins()
		end,
	},
}
