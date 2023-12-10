local M = {}

M.servers = {
	prettierd = {
		prefer_local = 'node_modules/.bin',
		extra_filetypes = {},
		extra_args = function (args)
		          local extra_args = {}

		          if not args.options.semi then table.insert(extra_args, '--semi=false') end
		          if not args.options.printWidth then table.insert(extra_args, '--print-width=140') end
		          if not args.options.singleQuote then table.insert(extra_args, '--single-quote=true') end

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
			'--collapse-simple-statement',
			'Always',
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

return {
    'nvimtools/none-ls.nvim',
	event = 'BufReadPre',
	config = function()
		local null_ls = require 'null-ls'
		local formattings = null_ls.builtins.formatting

		local sources = {}

		for name, config in pairs(M.servers) do
			table.insert(sources, formattings[name].with(config))
		end

		null_ls.setup {
			debounce = 10,
			sources = sources,
		}
	end,
}
