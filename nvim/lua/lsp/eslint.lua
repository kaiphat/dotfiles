local group = kaiphat.utils.create_augroup 'eslint'

kaiphat.setup_lsp_server {
	name = 'eslint',
	opts = {
		settings = {
			format = true,
		},
	},
	on_attach_hook = function(client, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd 'EslintFixAll'
				end)
			end,
		})
	end,
}
