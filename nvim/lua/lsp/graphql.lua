return {
	init = function(lsp, opts)
		lsp.graphql.setup(opts:to_server_opts())
	end,
}
