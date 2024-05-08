local luals = require 'lsp.luals'
local eslint = require 'lsp.eslint'
local rust = require 'lsp.rust'
local cssls = require 'lsp.cssls'
local sqlls = require 'lsp.sqlls'
local html = require 'lsp.html'
local emmet = require 'lsp.emmet'
local graphql = require 'lsp.graphql'
local pylsp = require 'lsp.pylsp'
local marksman = require 'lsp.marksman'

local servers = {
	luals,
	eslint,
	rust,
	cssls,
	sqlls,
	html,
	emmet,
	graphql,
	pylsp,
	marksman,
}

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     diagnostic     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
vim.diagnostic.config {
	float = {
		focusable = true,
		header = false,
		border = 'rounded',
		style = 'minimal',
		prefix = '',
	},
}

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     lsp symbols     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
	vim.fn.sign_define('LspDiagnosticsSign' .. hint, {
		text = ICONS.CIRCLE_SMALL,
		numhl = 'LspDiagnosticsSign' .. hint,
	})
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     setup handlers     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
local diagnostic_opts = {
	-- virtual_text = {
	-- 	spacing = 8,
	-- 	source = 'if_many',
	-- 	-- prefix = ' ',
	-- 	prefix = '●',
	-- },
	virtual_text = false,
	severity_sort = true,
	signs = false,
	underline = true,
	update_in_insert = false,
}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_opts)

vim.lsp.handlers['textDocument/definition'] = function(_, result)
	if not result or vim.tbl_isempty(result) then
		print '[LSP] Could not find definition'
		return
	end

	if vim.tbl_islist(result) then
		vim.lsp.util.jump_to_location(result[1], 'utf-8')
	else
		vim.lsp.util.jump_to_location(result, 'utf-8')
	end
end

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
				settings = {
					tsserver_file_preferences = {
						includeInlayParameterNameHints = 'all',
					},
					tsserver_format_options = {
						allowRenameOfImportPath = true,
					},
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

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local default_opts = {
                on_attach = function(client, bufnr) end,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			}

			for _, server in ipairs(servers) do
				local opts = vim.tbl_extend('force', {}, default_opts)

                local original_on_attach = opts.on_attach

				opts.expand_on_attach = function(hook)
					opts.on_attach = function(client, bufnr)
                        original_on_attach(client, bufnr)
						hook(client, bufnr)
					end
				end

				server.init(lsp, opts)
			end
		end,
	},
}
