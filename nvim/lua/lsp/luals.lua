local group = create_augroup 'lua_format'

return function(lsp, opts)
	opts:expand {
		settings = {
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
		},
	}

	opts:add_on_attach_hook(function(client, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.api.nvim_buf_call(bufnr, function()
					vim.lsp.buf.format { timeout_ms = 5000 }
				end)
			end,
		})
	end)

	lsp.lua_ls.setup(opts:to_server_opts())
end
