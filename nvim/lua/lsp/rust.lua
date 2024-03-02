return {
	init = function(lsp, opts)
		opts.settings = {
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
		}

		lsp.rust_analyzer.setup(opts)
	end,
}
