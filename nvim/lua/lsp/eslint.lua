return {
	init = function(lsp, opts)
		opts.settings = {
			format = true,
		}

		local original_on_attach = opts.on_attach
		local group = vim.api.nvim_create_augroup('custom:eslint', {})

		opts.on_attach = function(client, bufnr)
			original_on_attach(client, bufnr)

			vim.api.nvim_create_autocmd('BufWritePre', {
				group = group,
				buffer = bufnr,
				callback = function()
					vim.cmd 'EslintFixAll'
				end,
			})
		end

		lsp.eslint.setup(opts)
	end,
}
