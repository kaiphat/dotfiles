local group = kaiphat.utils.create_augroup 'lsp_attach_eslint'
vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(event)
		local server = vim.lsp.get_client_by_id(event.data.client_id)

		if not server or server.name ~= 'eslint' then
			return
		end

		vim.api.nvim_create_autocmd('BufWritePre', {
			group = group,
			buffer = event.buf,
			callback = function(newEvent)
				-- vim.api.nvim_buf_call(event.buf, function()
				vim.cmd 'LspEslintFixAll'
				-- end)
			end,
		})

		vim.keymap.set('n', '<leader>lf', function()
			vim.cmd 'LspEslintFixAll'
		end, { buffer = event.buf })
	end,
})

vim.lsp.config('eslint', {
	settings = {
		format = true,
	},
})
