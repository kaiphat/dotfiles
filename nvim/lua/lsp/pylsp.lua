return {
	init = function(lsp, opts)
		lsp.pylsp.setup(opts:to_server_opts())
	end,
}
