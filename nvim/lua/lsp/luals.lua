return {
	init = function(lsp, opts)
		opts.settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = {
						'vim',
						'redis',
						'awesome',
					},
				},
				format = {
					enable = false,
					defaultConfig = {
						indent_style = 'space',
						indent_size = '4',
						quoteStyle = 'signle',
					},
				},
				hint = {
					enable = false,
				},
			},
		}

		lsp.lua_ls.setup(opts)
	end,
}
