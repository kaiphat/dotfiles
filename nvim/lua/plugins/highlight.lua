return {
	'tzachar/local-highlight.nvim',
	event = 'BufReadPre',
	config = function()
		local hl = require 'local-highlight'

		hl.setup {
			hlgroup = 'LspReferenceText',
			cw_hlgroup = 'LspReferenceText',
		}

		vim.api.nvim_create_autocmd('BufRead', {
			pattern = { '*.*' },
			callback = function(data) hl.attach(data.buf) end,
		})
	end,
}
