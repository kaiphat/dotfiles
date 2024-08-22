local u = require 'utils'

local eslint_condition = function(utils)
	return utils.has_file { '.eslintrc.json', '.eslintrc.js', '.eslintrc' }
end

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

return {
	'nvimtools/none-ls.nvim',
	enabled = true,
	event = 'BufReadPre',
	config = function()
		local null_ls = require 'null-ls'

		local formattings = null_ls.builtins.formatting

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
					u.add_to_home_path 'dotfiles/sql_formatter.json',
				},
			},
		}

		null_ls.setup {
			debounce = 100,
			sources = sources,
		}
	end,
}
