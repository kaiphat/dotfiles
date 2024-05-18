return {
	init = function(lsp, opts)
		opts:expand {
			filetypes = {
				'html',
			},
		}

		lsp.emmet_language_server.setup(opts:to_server_opts())
	end,
}
