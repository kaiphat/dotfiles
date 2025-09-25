vim.lsp.config('lua_ls', {
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format { timeout_ms = 5000 }
			end,
		})
	end,
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			runtime = {
				version = 'LuaJIT',
				path = { 'lua/?.lua', '?/init.lua', '?/?.lua', '?.lua' },
			},
			diagnostics = {
				globals = {
					'vim',
					'redis',
					'awesome',
					'Snacks',
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
			telemetry = {
				enable = false,
			},
		},
	},
})
