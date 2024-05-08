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

		local group = vim.api.nvim_create_augroup('custom:lsp_formatting', {})

		opts.expand_on_attach(function(client, bufnr)
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = group,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format { timeout_ms = 5000 }
				end,
			})
		end)

		lsp.lua_ls.setup(opts)
	end,
}
