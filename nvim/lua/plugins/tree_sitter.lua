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
	-- 'norg',
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
						enable = false,
						goto_next_start = {
							[']]'] = '@function.outer',
							[']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
							[']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
						},
						goto_next_end = {
							[']['] = '@function.outer',
						},
						goto_previous_start = {
							['[['] = '@function.outer',
							['[s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
						},
						goto_previous_end = {
							['[]'] = '@function.outer',
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
						init_selection = '<Enter>',
						node_incremental = '<Enter>',
						node_decremental = '<BS>',
					},
				},
			}

			add_mixins()
		end,
	},
}
