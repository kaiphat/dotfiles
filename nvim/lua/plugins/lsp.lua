vim.diagnostic.config {
	float = {
		focusable = true,
		border = 'rounded',
		style = 'minimal',
		prefix = '',
	},
	virtual_text = false,
	severity_sort = true,
	signs = false,
	underline = true,
	update_in_insert = false,
}

for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
	vim.fn.sign_define(
		'LspDiagnosticsSign' .. hint,
		{ text = kaiphat.constants.icons.CIRCLE_SMALL, numhl = 'LspDiagnosticsSign' .. hint }
	)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = kaiphat.utils.create_augroup 'lsp_attach',
	callback = function(event)
		local map = function(mode, keys, cmd)
			vim.keymap.set(mode, keys, cmd, { buffer = event.buf })
		end

		map('n', 'gd', function()
			Snacks.picker.lsp_definitions()
		end)

		map('n', 'K', function()
			vim.lsp.buf.hover()
		end)

		map('n', '<leader>lk', function()
			vim.lsp.buf.signature_help()
		end)

		map('n', '<space>le', function()
			vim.diagnostic.open_float()
		end)

		map('n', '[d', function()
			vim.diagnostic.jump { count = -1, float = true }
		end)

		map('n', '[D', function()
			vim.diagnostic.jump {
				count = -1,
				float = true,
				severity = vim.diagnostic.severity.ERROR,
			}
		end)

		map('n', ']d', function()
			vim.diagnostic.jump { count = 1, float = true }
		end)

		map('n', ']D', function()
			vim.diagnostic.jump {
				count = 1,
				float = true,
				severity = vim.diagnostic.severity.ERROR,
			}
		end)

		map('n', '<space>lq', function()
			vim.diagnostic.setqflist()
		end)

		map('n', '<space>ls', function()
			vim.diagnostic.show()
		end)

		map({ 'n', 'v' }, '<space>la', function()
			vim.lsp.buf.code_action()
		end)

		map('n', '<space>lr', function()
			vim.lsp.buf.rename()
		end)

		map('n', '<space>lih', function()
			local is_enabled = vim.lsp.inlay_hint.is_enabled()
			vim.lsp.inlay_hint.enable(not is_enabled)
		end)

		map('n', '<space>lcl', function()
			vim.lsp.codelens.refresh()
		end)

		map('n', 'go', function()
			vim.cmd 'vs'
			Snacks.picker.lsp_definitions()
		end)

		map('n', 'gs', function()
			local row = vim.api.nvim_win_get_cursor(0)[1]
			vim.cmd 'split'
			vim.schedule(function()
				vim.cmd.normal(row .. 'gg')
				vim.lsp.buf.definition()
				vim.api.nvim_input 'zz'
			end)
		end)

		map({ 'n', 'v' }, '<leader>lf', function()
			vim.lsp.buf.format { timeout_ms = 5000 }
		end)
	end,
})

return {
	{
		'mason-org/mason.nvim',
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

	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		cmd = { 'MasonToolsInstall' },
		config = function()
			require('mason-tool-installer').setup {
				auto_update = false,
				run_on_start = false,
				ensure_installed = {
					-- ls
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
					'llm-ls',
					'jdtls',

					-- dap
					'js-debug-adapter',
				},
			}
		end,
	},

	{
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		dependencies = {
			'nvimtools/none-ls.nvim',
			'yioneko/nvim-vtsls',
			'saghen/blink.cmp',
		},
		config = function()
			vim.lsp.config('*', {
				capabilities = require('blink.cmp').get_lsp_capabilities {
					textDocument = {
						semanticTokens = {
							multilineTokenSupport = true,
						},
					},
				},
				root_markers = { '.git' },
			})

			for _, server in ipairs {
				'lua_ls',
				'nushell',
				'vtsls',
				'eslint',
				'rust_analyzer',
			} do
				vim.lsp.enable(server)
			end
		end,
	},

	{
		'mfussenegger/nvim-jdtls',
		ft = { 'java' },
		enabled = false,
		config = function()
			local mason_path = vim.fn.stdpath 'data' .. '/mason'
			local jdtls_path = mason_path .. '/packages/jdtls'
			local lombok_path = jdtls_path .. '/lombok.jar'
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
			local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name

			local os = 'unknown-os'
			if vim.fn.has 'mac' == 1 then
				os = 'mac'
			elseif vim.fn.has 'unix' == 1 then
				os = 'linux'
			elseif vim.fn.has 'win32' == 1 then
				os = 'win'
			end

			require('jdtls').start_or_attach {
				cmd = {
					'java',
					'-javaagent:' .. lombok_path,
					'-Declipse.application=org.eclipse.jdt.ls.core.id1',
					'-Dosgi.bundles.defaultStartLevel=4',
					'-Declipse.product=org.eclipse.jdt.ls.core.product',
					'-Dlog.protocol=true',
					'-Dlog.level=ALL',
					'-Xmx1g',
					'--add-modules=ALL-SYSTEM',
					'--add-opens',
					'java.base/java.util=ALL-UNNAMED',
					'--add-opens',
					'java.base/java.lang=ALL-UNNAMED',
					'-jar',
					vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
					'-configuration',
					jdtls_path .. '/config_' .. os,
					'-data',
					workspace_dir,
				},
				root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
			}
		end,
	},
}
