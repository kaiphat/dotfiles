return function(lsp, opts)
	opts:expand {
		settings = {
			['rust-analyzer'] = {
				assist = {
					importGranularity = 'module',
					importPrefix = 'self',
				},
				diagnostics = {
					enable = true,
					enableExperimental = true,
				},
				cargo = {
					loadOutDirsFromCheck = true,
				},
				procMacro = {
					enable = true,
				},
				inlayHints = {
					chainingHints = true,
					parameterHints = true,
					typeHints = true,
				},
			},
		},
	}

	lsp.rust_analyzer.setup(opts:to_server_opts())
end
