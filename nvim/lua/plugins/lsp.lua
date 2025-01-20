-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     diagnostic     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
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

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     lsp symbols     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
	vim.fn.sign_define(
		'LspDiagnosticsSign' .. hint,
		{ text = kaiphat.constants.icons.CIRCLE_SMALL, numhl = 'LspDiagnosticsSign' .. hint }
	)
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     setup handlers     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
vim.lsp.handlers['textDocument/definition'] = function(_, result)
	if not result or vim.tbl_isempty(result) then
		print '[LSP] Could not find definition'
		return
	end

	if result then
		vim.lsp.util.jump_to_location(result[1], 'utf-8')
	end
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     keymaps     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
vim.api.nvim_create_autocmd('LspAttach', {
	group = kaiphat.utils.create_augroup 'lsp_attach',
	callback = function(event)
		local map = function(mode, keys, cmd)
			vim.keymap.set(mode, keys, cmd, { buffer = event.buf })
		end

		local function open_float()
			vim.defer_fn(function()
				vim.diagnostic.open_float()
			end, 300)
		end

		map('n', 'gd', function()
			vim.lsp.buf.definition {
				reuse_win = true,
			}
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
			vim.diagnostic.goto_prev()
			-- vim.diagnostic.get_next {
			-- 	count = -1,
			-- }
			open_float()
		end)

		map('n', '[D', function()
			vim.diagnostic.goto_prev {
				severity = vim.diagnostic.severity.ERROR,
			}
			-- vim.diagnostic.get_prev {
			-- 	count = -1,
			-- 	severity = vim.diagnostic.severity.ERROR,
			-- }
			open_float()
		end)

		map('n', ']d', function()
			vim.diagnostic.goto_next()
			-- vim.diagnostic.jump {
			-- 	count = 1,
			-- }
			open_float()
		end)

		map('n', ']D', function()
			vim.diagnostic.goto_next {
				severity = vim.diagnostic.severity.ERROR,
			}

			-- vim.diagnostic.jump {
			-- 	count = 1,
			-- 	severity = vim.diagnostic.severity.ERROR,
			-- }
			open_float()
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

		map('n', 'go', function()
			vim.cmd 'vs'
			vim.lsp.buf.definition()
			vim.schedule(function()
				vim.api.nvim_input 'zz'
			end)
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

kaiphat.setup_lsp_server = function(table)
	local lsp = require 'lspconfig'
	local capabilities = require('blink.cmp').get_lsp_capabilities()

	local opts = {
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = function(client, bufnr)
			if table.on_attach_hook then
				table.on_attach_hook(client, bufnr)
			end
			if vim.lsp.handlers['textDocument/inlayHint'] then
				vim.lsp.inlay_hint.enable()
			end
		end,
	}

	if table.opts then
		opts = vim.tbl_extend('force', opts, table.opts)
	end

	lsp[table.name].setup(opts)
end

return {
	{
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		dependencies = {
			'jose-elias-alvarez/null-ls.nvim',
			'yioneko/nvim-vtsls',
			'saghen/blink.cmp',
		},
		init_options = {
			userLanguages = {
				eelixir = 'html-eex',
				eruby = 'erb',
				rust = 'html',
			},
		},
		config = function()
			for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath 'config' .. '/lua/lsp')) do
				require('lsp.' .. file:gsub('%.lua$', ''))
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
