local M = {}

M.tools = {
	'lua-language-server',
	'prettierd',
	'rust-analyzer',
	'typescript-language-server',
	'json-lsp',
	'css-lsp',
	'html-lsp',
	'json-lsp',
	'sql-formatter',
	'emmet-language-server',
	'stylua',
	'eslint_d',
}

return {
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		cmd = { 'MasonToolsInstall' },
		config = function()
			require('mason-tool-installer').setup {
				auto_update = false,
				run_on_start = false,
				ensure_installed = M.tools,
			}
		end,
	},

	{
		'williamboman/mason.nvim',
		event = 'BufReadPre',
		config = function()
			require('mason').setup {
				ui = {
					border = 'rounded',
					width = 0.5,
				},
			}
		end,
	},
}
