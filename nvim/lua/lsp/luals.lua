local u = require 'utils'
local group = u.create_augroup 'lua_format'

return function(lsp, opts)
	opts:expand {
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
	}

	opts:set_on_attach_hook(function(client, bufnr)
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
