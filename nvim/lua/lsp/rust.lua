kaiphat.setup_lsp_server {
	name = 'rust_analyzer',
	opts = {
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
	},
}
