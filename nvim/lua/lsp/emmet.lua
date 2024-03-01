return {
	init = function(lsp, opts)
		opts.filetypes = {
			'html',
		}

        lsp.emmet_language_server.setup(opts)
	end,
}
