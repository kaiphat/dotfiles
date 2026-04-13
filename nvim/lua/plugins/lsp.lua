vim.diagnostic.config {
	float = {
		focusable = true,
		border = 'rounded',
		style = 'minimal',
		prefix = '',
	},
	virtual_text = true,
	severity_sort = true,
	signs = false,
	underline = true,
	update_in_insert = false,
}

for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
	vim.fn.sign_define(
		'LspDiagnosticsSign' .. hint,
		{ text = __.constants.icons.CIRCLE_SMALL, numhl = 'LspDiagnosticsSign' .. hint }
	)
end

vim.api.nvim_create_autocmd('LspProgress', {
	callback = function(ev)
		local value = ev.data.params.value or {}
		local msg = value.message or 'done'

		-- rust analyszer in particular has really long LSP messages so truncate them
		if #msg > 40 then
			msg = msg:sub(1, 37) .. '...'
		end

		vim.api.nvim_echo(
			{
				{
					msg,
				},
			},
			false,
			{
				id = 'lsp',
				source = 'lsp',
				kind = 'progress',
				title = value.title,
				status = value.kind ~= 'end' and 'running' or 'success',
				percent = value.percentage,
			}
		)
	end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = __.utils.create_augroup 'lsp_attach',
	callback = function(event)
		local function map(mode, keys, cmd)
			vim.keymap.set(mode, keys, cmd, { buffer = event.buf })
		end

		map('n', 'gd', function()
			__.picker.lsp_definitions()
		end)

		map('n', 'go', function()
			vim.cmd 'vs'
			__.picker.lsp_definitions()
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
			vim.lsp.codelens.enable(true)
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

__.add_plugin {
	'mason-org/mason.nvim',
	cmds = { 'Mason' },
	load = function(_)
		_.setup {
			ui = {
				border = 'rounded',
				width = 0.7,
			},
		}
	end,
}

__.add_plugin {
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	deps = { 'mason' },
	cmds = { 'MasonToolsInstall' },
	load = function(_)
		_.setup {
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
}

__.add_plugin {
	'neovim/nvim-lspconfig',
	event = 'LspAttach',
	deps = {
		'null-ls',
		'mason',
		'blink.cmp',
		'lsp-file-operations',
	},
	load = function()
		local init_capabilities = {
			textDocument = {
				semanticTokens = {
					multilineTokenSupport = true,
				},
			},
		}

		local capabilities =
			vim.tbl_deep_extend('force', init_capabilities, require('lsp-file-operations').default_capabilities())

		vim.lsp.config('*', {
			capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
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
}

__.add_plugin {
	'antosha417/nvim-lsp-file-operations',
	deps = {
		'plenary',
	},
}
