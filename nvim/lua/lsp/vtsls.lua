local function on_resolve() end
local function on_reject(msg)
	print('Vtsls error: ' .. msg)
end

return function(lsp, opts)
	opts:add_on_attach_hook(function(client, bufnr)
		vim.keymap.set('n', '<leader>ti', function()
			require('vtsls').commands.add_missing_imports(0, on_resolve, on_reject)
		end)
		vim.keymap.set('n', '<leader>tr', function()
			require('vtsls').commands.rename_file(0, on_resolve, on_reject)
		end)
		vim.keymap.set('n', '<leader>td', function()
			require('vtsls').commands.remove_unused_imports(0, on_resolve, on_reject)
		end)
		vim.keymap.set('n', '<leader>to', function()
			require('vtsls').commands.organize_imports(0, on_resolve, on_reject)
		end)
	end)

	opts:expand {
		settings = {
			typescript = {
				format = {
					allowRenameOfImportPath = true,
					insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
					insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
					insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
					quotePreference = 'single',
				},
			},
		},
	}

	lsp.vtsls.setup(opts:to_server_opts())
end
