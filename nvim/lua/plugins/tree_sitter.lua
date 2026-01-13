vim.treesitter.query.set(
	'typescript',
	'injections',
	[[
        (
            (template_string (string_fragment) @injection.content)
            (#match? @injection.content "FROM|ALTER|SELECT|CREATE|UPDATE|DELETE|INSERT|WITH")
            (#set! injection.language "sql")
        )

        (
            (template_string (string_fragment) @injection.content)
            (#match? @injection.content "local|redis")
            (#set! injection.language "lua")
        )

        (
            (comment) @injection.content
            (#match? @injection.content "^/\\*\\*")
            (#set! injection.language "jsdoc")
        )
    ]]
)

local languges = {
	'javascript',
	'rust',
	'typescript',
	'toml',
	'yaml',
	'vim',
	'tsx',
	'markdown',
	'markdown_inline',
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
	'nu',
	'graphql',
	'latex',
	'svelte',
	'typst',
	'vue',
	'ecma',
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
			max_lines = 3,
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch = 'main',
		enabled = true,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup {
				install_dir = vim.fn.stdpath 'data' .. '/site',
				indent = {
					enable = true,
				},
			}

			require('nvim-treesitter').install(languges)

			vim.api.nvim_create_autocmd('FileType', {
				group = kaiphat.utils.create_augroup 'treesitter_indent',
				callback = function(info)
					local ft = vim.bo[info.buf].filetype

					if ft == 'copilot-chat' then
						ft = 'markdown'
					end

					if vim.treesitter.language.add(ft) then
						vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'

						vim.treesitter.start()
					end
				end,
			})
		end,
	},
}
