local u = require 'utils'
local group = u.create_augroup 'eslint'

return function(lsp, opts)
	opts:expand {
		settings = {
			format = true,
		},
	}

	opts:add_on_attach_hook(function(client, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd 'EslintFixAll'
				end)
			end,
		})
	end)

	lsp.eslint.setup(opts:to_server_opts())
end
