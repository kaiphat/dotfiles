return {
	on_attach = function(client, buffer)
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = buffer,
			callback = function(event)
				local namespace = vim.lsp.diagnostic.get_namespace(client.id, 'eslint')
				local diagnostics = vim.diagnostic.get(event.buf, { namespace = namespace })
				if #diagnostics > 0 then
					vim.lsp.buf.format {
						async = false,
						timeout_ms = 5000,
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
}
