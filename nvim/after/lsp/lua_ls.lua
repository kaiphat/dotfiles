local group = kaiphat.utils.create_augroup 'lsp_attach_lua'
vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(event)
		local server = vim.lsp.get_client_by_id(event.data.client_id)

		if not server or server.name ~= 'lua_ls' then
			return
		end

		vim.api.nvim_create_autocmd('BufWritePre', {
			group = group,
			buffer = event.buf,
			callback = function()
				-- vim.api.nvim_buf_call(event.buf, function()
				vim.lsp.buf.format { timeout_ms = 5000 }
				-- end)
			end,
		})
	end,
})

vim.lsp.config('lua_ls', {
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
