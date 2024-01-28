local formatting_servers = {
	prettier = {
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
	stylua = {
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
	sql_formatter = {
		extra_filetypes = { 'man' },
		extra_args = {
			'-l',
			'postgresql',
			'-c',
			add_to_home_path 'dotfiles/sql_formatter.json',
		},
	},
}

local action_servers = {
	eslint_d = {},
}

local function get_diagnostic_servers(null_ls)
	return {
		eslint_d = {
			condition = function(utils)
				return utils.root_has_file { '.eslintrc.json', '.eslintrc.js', '.eslintrc' }
			end,
			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
			filter = function(diagnostic)
				for _, code in ipairs {
					'no-multiple-empty-lines',
					'comma-dangle',
					'semi',
					'object-curly-spacing',
					'space-before-function-paren',
					'eol',
				} do
					if diagnostic.code == code then
						return false
					end
				end

				return true
			end,
			diagnostic_config = {
				signs = false,
				update_in_insert = false,
			},
		},
	}
end

return {
	'nvimtools/none-ls.nvim',
	-- 'jose-elias-alvarez/null-ls.nvim',
	enabled = true,
	event = 'BufReadPre',
	config = function()
		local null_ls = require 'null-ls'

		local formattings = null_ls.builtins.formatting
		local code_actions = null_ls.builtins.code_actions
		local diagnostics = null_ls.builtins.diagnostics

		local sources = {}

		for name, config in pairs(formatting_servers) do
			table.insert(sources, formattings[name].with(config))
		end

		for name, config in pairs(action_servers) do
			table.insert(sources, code_actions[name].with(config))
		end

		for name, config in pairs(get_diagnostic_servers(null_ls)) do
			table.insert(sources, diagnostics[name].with(config))
		end

		null_ls.setup {
			debounce = 100,
			sources = sources,
		}
	end,
}
