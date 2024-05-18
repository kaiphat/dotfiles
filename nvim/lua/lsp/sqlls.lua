return {
	init = function(lsp, opts)
		lsp.sqlls.setup(opts:to_server_opts())
	end,
}
