return {
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		cmd = { 'MasonToolsInstall' },
		config = function()
			require('mason-tool-installer').setup {
				auto_update = false,
				run_on_start = false,
				ensure_installed = {
					'lua-language-server',
					'prettierd',
					'prettier',
					'rust-analyzer',
					-- 'typescript-language-server',
					'json-lsp',
					'css-lsp',
					'html-lsp',
					'json-lsp',
					'sql-formatter',
					'emmet-language-server',
					'stylua',
					'python-lsp-server',
					'eslint-lsp',
					'marksman',
					'vtsls',
				},
			}
		end,
	},

	{
		'williamboman/mason.nvim',
		event = 'BufReadPre',
		cmd = { 'Mason' },
		config = function()
			require('mason').setup {
				ui = {
					border = 'rounded',
					width = 0.7,
				},
			}
		end,
	},
}
