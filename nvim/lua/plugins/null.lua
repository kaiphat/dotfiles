local formatting_servers = {
	prettierd = {
		prefer_local = 'node_modules/.bin',
		extra_filetypes = {},
		extra_args = function(args)
			local extra_args = {}

			if not args.options.semi then table.insert(extra_args, '--semi=false') end
			if not args.options.printWidth then table.insert(extra_args, '--print-width=140') end
			if not args.options.singleQuote then table.insert(extra_args, '--single-quote=true') end
			if not args.options.tabWidth then table.insert(extra_args, '--tab-width=' .. vim.o.tabstop) end

			return extra_args
		end,
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

local diagnostic_servers = {
	eslint_d = {
		filter = function(diagnostic)
			for _, code in ipairs {
				'no-multiple-empty-lines',
				'comma-dangle',
				'semi',
				'object-curly-spacing',
				'space-before-function-paren',
			} do
				if diagnostic.code == code then return false end
			end

			return true
		end,
		diagnostic_config = {
			signs = false,
            update_in_insert = false,
		},
	},
}

return {
	-- 'nvimtools/none-ls.nvim',
	'jose-elias-alvarez/null-ls.nvim',
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

		for name, config in pairs(diagnostic_servers) do
			table.insert(sources, diagnostics[name].with(config))
		end

		null_ls.setup {
			debounce = 10,
			sources = sources,
		}
	end,
}
