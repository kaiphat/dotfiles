local function on_resolve() end
local function on_reject(msg)
	print('Vtsls error: ' .. msg)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = kaiphat.utils.create_augroup 'lsp_attach_vtsls',
	callback = function(event)
		local server = vim.lsp.get_client_by_id(event.data.client_id)

		if not server or server.name ~= 'vtsls' then
			return
		end

		vim.keymap.set('n', '<leader>ti', function()
			require('vtsls').commands.add_missing_imports(0, on_resolve, on_reject)
		end, { buffer = event.buf })

		vim.keymap.set('n', '<leader>tr', function()
			require('vtsls').commands.rename_file(0, on_resolve, on_reject)
		end, { buffer = event.buf })

		vim.keymap.set('n', '<leader>td', function()
			require('vtsls').commands.remove_unused_imports(0, on_resolve, on_reject)
		end, { buffer = event.buf })

		vim.keymap.set('n', '<leader>to', function()
			require('vtsls').commands.organize_imports(0, on_resolve, on_reject)
		end, { buffer = event.buf })
	end,
})

vim.lsp.config('vtsls', {
	settings = {
		typescript = {
			format = {
				allowRenameOfImportPath = true,
				insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
				insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
				insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
				quotePreference = 'single',
			},
			inlayHints = {
				parameterNames = { enabled = 'literals' },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
			referencesCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
			},
			implementationsCodeLens = {
				enabled = true,
				showOnInterfaceMethods = true,
			},
			implicitProjectConfig = {
				experimentalDecorators = true,
			},
		},
	},
})
