local prettier_condition = function(utils)
	if utils.has_file { '.prettierrc.toml' } then
		return true
	end

	local allowed_fts = {
		'json',
		'yaml',
		'markdown',
		'toml',
	}

	local ft = vim.bo.filetype
	for _, allowed_ft in ipairs(allowed_fts) do
		if ft == allowed_ft then
			return true
		end
	end
end

__.add_plugin {
	'nvimtools/none-ls.nvim',
	name = 'null-ls',
	event = 'BufReadPre',
	load = function(_)
		local formattings = _.builtins.formatting

		local sources = {
			formattings.prettier.with {
				condition = prettier_condition,
				prefer_local = 'node_modules/.bin',
				extra_filetypes = {},
				extra_args = {
					'--config-precedence=prefer-file',
					'--semi=false',
					'--print-width=140',
					'--single-quote=true',
					'--no-bracket-spacing',
					'--arrow-parens=avoid',
					'--tab-width=' .. vim.o.tabstop,
				},
			},
			formattings.stylua.with {
				extra_args = {
					'--quote-style',
					'ForceSingle',
					'--call-parentheses',
					'None',
					'--indent-width',
					'4',
					'--indent-type',
					'Tabs',
				},
			},
			formattings.sql_formatter.with {
				extra_filetypes = { 'man' },
				extra_args = {
					'-l',
					'postgresql',
					'-c',
					__.utils.add_to_home_path 'dotfiles/sql_formatter.json',
				},
			},
		}

		_.setup {
			debounce = 100,
			sources = sources,
		}
	end,
}
