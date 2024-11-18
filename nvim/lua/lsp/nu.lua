return function(lsp, opts)
	lsp.nushell.setup(opts:to_server_opts())
end
