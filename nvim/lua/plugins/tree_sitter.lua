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
	'java',
	'javadoc',
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
	'dart',
}

__.add_plugin {
	'nvim-treesitter/nvim-treesitter',
	name = 'nvim-treesitter',
	version = 'main',
	event = 'BufReadPre',
	load = function(p)
		p.setup {
			install_dir = vim.fn.stdpath 'data' .. '/site',
			indent = {
				enable = true,
			},
		}

		p.install(languges)

		vim.api.nvim_create_autocmd('FileType', {
			group = __.utils.create_augroup 'treesitter_indent',
			callback = function(info)
				local ft = vim.bo[info.buf].filetype

				if ft == 'copilot-chat' then
					ft = 'markdown'
				end

				if vim.treesitter.language.add(ft) then
					vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'

					vim.treesitter.start()

					vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.wo[0][0].foldmethod = 'expr'
				end
			end,
		})
	end,
}

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'nvim-treesitter' and kind == 'update' then
			if not ev.data.active then
				vim.cmd.packadd 'nvim-treesitter'
			end

			vim.cmd 'TSUpdate'
		end
	end,
})
