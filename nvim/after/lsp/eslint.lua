vim.lsp.config('eslint', {
	on_attach = function(client, buffer)
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = buffer,
			callback = function(event)
				local namespace = vim.lsp.diagnostic.get_namespace(client.id, true)
				local diagnostics = vim.diagnostic.get(event.buf, { namespace = namespace })
				if #diagnostics > 0 then
					vim.lsp.buf.format {
						async = false,
						filter = function(formatter)
							return formatter.name == 'eslint'
						end,
					}
				end
			end,
		})
	end,
	settings = {
		format = { enable = true },
		workingDirectory = { mode = 'auto' },
		codeActionOnSave = { enable = true, mode = 'problems' },
	},
})
