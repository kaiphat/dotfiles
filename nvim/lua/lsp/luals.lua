local group = kaiphat.utils.create_augroup 'lua_format'

kaiphat.setup_lsp_server {
	name = 'lua_ls',
	opts = {
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
	},
	on_attach_hook = function(client, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.api.nvim_buf_call(bufnr, function()
					vim.lsp.buf.format { timeout_ms = 5000 }
				end)
			end,
		})
	end,
}
