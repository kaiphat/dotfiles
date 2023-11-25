local M = {}

M.set_lsp_symbols = function()
	local char = '│'

	for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
		vim.fn.sign_define('LspDiagnosticsSign' .. hint, {
			text = char,
			numhl = 'LspDiagnosticsSign' .. hint,
		})
	end
end

M.publish_diagnostics_opts = {
	virtual_text = {
		spacing = 8,
		source = 'if_many',
		-- prefix = ' ',
		prefix = '●',
	},
	severity_sort = true,
	signs = false,
	underline = true,
	update_in_insert = false,
}

M.set_handlers = function()
	vim.lsp.handlers['textDocument/publishDiagnostics'] =
		vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, M.publish_diagnostics_opts)

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
end

M.on_attach = function(client, bufnr)
	if client.supports_method 'textDocument/semanticTokens' then
		client.server_capabilities.semanticTokensProvider = nil
	end

	-- vim.api.nvim_create_augroup('lsp_augroup', { clear = true })
	--
	-- vim.api.nvim_create_autocmd('InsertEnter', {
	--   buffer = bufnr,
	--   callback = function()
	--     vim.lsp.inlay_hint(bufnr, true)
	--   end,
	--   group = 'lsp_augroup',
	-- })
	--
	-- vim.api.nvim_create_autocmd('InsertLeave', {
	--   buffer = bufnr,
	--   callback = function()
	--     vim.lsp.inlay_hint(bufnr, false)
	--   end,
	--   group = 'lsp_augroup',
	-- })
end

M.get_servers = function()
	return {
		cssls = {},
		sqlls = {},
		html = {},
		emmet_language_server = {
			filetypes = {
				'html',
			},
		},
		graphql = {},
		pylsp = {},
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					runtime = {
						version = 'LuaJIT',
					},
					diagnostics = {
						globals = {
							'vim',
							'redis',
							'awesome',
						},
					},
					format = {
						enable = false,
						defaultConfig = {
							indent_style = 'space',
							indent_size = '4',
							quoteStyle = 'signle',
						},
					},
					hint = {
						enable = false,
					},
				},
			},
		},
		rust_analyzer = {
			settings = {
				['rust-analyzer'] = {
					-- assist = {
					-- 	importGranularity = 'module',
					-- 	importPrefix = 'self',
					-- },
					-- diagnostics = {
					-- 	enable = true,
					-- 	enableExperimental = true,
					-- },
					-- cargo = {
					-- 	loadOutDirsFromCheck = true,
					-- },
					-- procMacro = {
					-- 	enable = true,
					-- },
					-- inlayHints = {
					-- 	chainingHints = true,
					-- 	parameterHints = true,
					-- 	typeHints = true,
					-- },
				},
			},
		},
	}
end

M.get_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { 'markdown', 'plaintext' },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				'documentation',
				'detail',
				'additionalTextEdits',
			},
		},
	}

	return capabilities
end

return {
	{
		'pmizio/typescript-tools.nvim',
		enabled = true,
		event = 'BufReadPre',
		keys = {
			{ '<leader>ti', ':TSToolsAddMissingImports<cr>' },
			{ '<leader>tr', ':TSToolsRenameFile<cr>' },
			{ '<leader>td', ':TSToolsRemoveUnused<cr>' },
			{ '<leader>to', ':TSToolsOrganizeImports<cr>' },
		},
		config = function()
			local api = require 'typescript-tools.api'

			require('typescript-tools').setup {
				on_attach = M.on_attach,
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
						M.publish_diagnostics_opts
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
		keys = {
			{ 'gd', function()
				vim.lsp.buf.definition {
					reuse_win = true,
				}
			end },
			{ 'K', function() vim.lsp.buf.hover() end },
			{ '<leader>lk', function() vim.lsp.buf.signature_help() end },
			{ '<space>le', function() vim.diagnostic.open_float() end },
			{ '[d', function() vim.diagnostic.goto_prev() end },
			{ ']d', function() vim.diagnostic.goto_next() end },
			{ '<space>lq', function() vim.diagnostic.setqflist() end },
			{ '<space>ls', function() vim.diagnostic.show() end },
			{ '<space>la', function() vim.lsp.buf.code_action() end },
			{ '<space>lr', function() vim.lsp.buf.rename() end },
			{
				'go',
				function()
					vim.cmd 'vs'
					vim.lsp.buf.definition()
				end,
			},
			{ '<leader>lf', function() vim.lsp.buf.format { timeout_ms = 5000 } end },
		},
		config = function()
			local lsp = require 'lspconfig'

			M.set_handlers()

			for server_name, opts in pairs(M.get_servers()) do
				local server = opts.custom_server or lsp[server_name]
				local settings = opts.custom_settings
					or merge({
						on_attach = M.on_attach,
						capabilities = M.get_capabilities(),
						flags = {
							debounce_text_changes = 150,
						},
					}, opts)

				server.setup(settings)
			end
		end,
	},
}
