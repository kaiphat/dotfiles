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

local add_mixins = function()
	-- vim.treesitter.language.register('fish', 'noext')
end

local add_folds = function()
	local treesitter_parsers = require 'nvim-treesitter.parsers'

	if treesitter_parsers.has_parser 'typescript' then
		-- require('vim.treesitter.query').set(
		-- 	'typescript',
		-- 	'folds',
		-- 	[[
		--               [
		--                   (statement_block)
		--               ] @fold
		--           ]]
		-- )
	end
end

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
			{ 'nushell/tree-sitter-nu', build = ':TSUpdate nu' },
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			local install = require 'nvim-treesitter.install'
			local config = require 'nvim-treesitter.configs'

			add_folds()

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

			add_mixins()
		end,
	},
}
