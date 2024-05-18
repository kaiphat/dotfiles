return {
	init = function(lsp, opts)
		opts:expand {
			settings = {
				format = true,
			},
		}

		opts:add_on_attach_hook(function(client, bufnr)
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = create_augroup 'eslint',
				buffer = bufnr,
				callback = function()
					vim.cmd 'EslintFixAll'
				end,
			})
		end)

		lsp.eslint.setup(opts:to_server_opts())
	end,
}
