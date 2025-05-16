vim.lsp.config('rust_analyzer', {
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
})
