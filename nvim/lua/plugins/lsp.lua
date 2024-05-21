-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     diagnostic     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
local diagnostic_opts = {
	float = {
		focusable = true,
		header = false,
		border = 'rounded',
		style = 'minimal',
		prefix = '',
		source = 'always',
	},
	virtual_text = false,
	severity_sort = true,
	signs = false,
	underline = true,
	update_in_insert = false,
}
vim.diagnostic.config(diagnostic_opts)

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     lsp symbols     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
	vim.fn.sign_define('LspDiagnosticsSign' .. hint, {
		text = ICONS.CIRCLE_SMALL,
		numhl = 'LspDiagnosticsSign' .. hint,
	})
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     setup handlers     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- vim.lsp.handlers['textDocument/definition'] = function(_, result)
-- 	if not result or vim.tbl_isempty(result) then
-- 		print '[LSP] Could not find definition'
-- 		return
-- 	end
--
-- 	if vim.tbl_islist(result) then
-- 		vim.lsp.util.jump_to_location(result[1], 'utf-8')
-- 	else
-- 		vim.lsp.util.jump_to_location(result, 'utf-8')
-- 	end
-- end
--
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     keymaps     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
vim.api.nvim_create_autocmd('LspAttach', {
	group = create_augroup 'lsp_attach',
	callback = function(event)
		local map = function(mode, keys, cmd)
			vim.keymap.set(mode, keys, cmd, { buffer = event.buf })
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
		end)

		map('n', ']d', function()
			vim.diagnostic.goto_next()
		end)

		map('n', '<space>lq', function()
			vim.diagnostic.setqflist()
		end)

		map('n', '<space>ls', function()
			vim.diagnostic.show()
		end)

		map({ 'n', 'v' }, '<space>la', function()
			require('fzf-lua').lsp_code_actions {}
		end)

		map('n', '<space>lr', function()
			vim.lsp.buf.rename()
		end)

		map('n', 'go', function()
			vim.cmd 'vs'
			vim.lsp.buf.definition()
			vim.defer_fn(function()
				vim.api.nvim_input 'zz'
			end, 50)
		end)

		map({ 'n', 'v' }, '<leader>lf', function()
			vim.lsp.buf.format { timeout_ms = 5000 }
		end)
	end,
})

local Opts = {}

Opts.__index = Opts

function Opts:new(capabilities)
	local obj = setmetatable({
		on_attach_hook = nil,
	}, self)

	obj.default = {
		on_attach = function(client, bufnr)
			if obj.on_attach_hook then
				obj.on_attach_hook(client, bufnr)
			end
			-- if vim.lsp.handlers['textDocument/inlayHint'] then
			-- 	vim.lsp.inlay_hint.enable()
			-- end
		end,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	return obj
end

function Opts:add_on_attach_hook(hook)
	self.on_attach_hook = hook
end

function Opts:expand(table)
	self.default = vim.tbl_extend('force', self.default, table)
end

function Opts:to_server_opts()
	return self.default
end

return {
	{
		'pmizio/typescript-tools.nvim',
		event = 'BufReadPre',
		keys = {
			{ '<leader>ti', ':TSToolsAddMissingImports<cr>' },
			{ '<leader>tr', ':TSToolsRenameFile<cr>' },
			{ '<leader>td', ':TSToolsRemoveUnusedImports<cr>' },
			{ '<leader>to', ':TSToolsOrganizeImports<cr>' },
		},
		config = function()
			local api = require 'typescript-tools.api'

			require('typescript-tools').setup {
				on_attach = function(client)
					-- vim.lsp.inlay_hint.enable()
				end,
				settings = {
					tsserver_file_preferences = {
						includeInlayParameterNameHints = 'all',
					},
					tsserver_format_options = {
						allowRenameOfImportPath = true,
					},
					-- code_lens = 'all',
					complete_function_calls = false,
				},
				handlers = {
					['textDocument/publishDiagnostics'] = vim.lsp.with(
						api.filter_diagnostics {
							80004, -- JSDoc may be converted
							80005, -- require call may be converted to an import
							7044, -- any type
							7045, -- any type
						},
						diagnostic_opts
					),
				},
			}
		end,
	},

	{
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		dependencies = {
			'jose-elias-alvarez/null-ls.nvim',
			'pmizio/typescript-tools.nvim',
		},
		init_options = {
			userLanguages = {
				eelixir = 'html-eex',
				eruby = 'erb',
				rust = 'html',
			},
		},
		config = function()
			local lsp = require 'lspconfig'
			local cmp = require 'cmp_nvim_lsp'

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, cmp.default_capabilities())

			for _, server in ipairs {
				'luals',
				'eslint',
				'rust',
				'cssls',
				'sqlls',
				'html',
				'emmet',
				'graphql',
				'pylsp',
				'marksman',
				-- 'vtsls',
			} do
				require('lsp.' .. server)(lsp, Opts:new(capabilities))
			end
		end,
	},
}
