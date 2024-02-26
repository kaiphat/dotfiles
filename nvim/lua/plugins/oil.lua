return {
	'stevearc/oil.nvim',
	keys = {
		{
			'<leader>o',
			function()
				require('oil').open()
			end,
		},
		{
			'<leader>O',
			function()
				require('oil').open(vim.loop.cwd())
			end,
		},
	},
	config = function()
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('oil_file_type', {}),
			pattern = 'oil',
			callback = function(event)
				vim.api.nvim_buf_set_keymap(event.buf, 'n', '<C-j>', 'j', {})
				vim.api.nvim_buf_set_keymap(event.buf, 'n', '<C-k>', 'k', {})
			end,
		})

		require('oil').setup {
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = false,
			lsp_rename_autosave = false,

			cleanup_delay_ms = false,
			use_default_keymaps = false,
			keymaps = {
				['<C-l>'] = 'actions.select',
				['<CR>'] = 'actions.select_vsplit',
				['<C-p>'] = 'actions.preview',
				['<C-c>'] = 'actions.close',
				['<C-h>'] = 'actions.parent',
				-- ['g.'] = 'actions.toggle_hidden',
				-- ['g\\'] = 'actions.toggle_trash',
				-- ['g?'] = 'actions.show_help',
				-- ['<C-h>'] = 'actions.select_split',
				-- ['<C-t>'] = 'actions.select_tab',
				-- ['<C-l>'] = 'actions.refresh',
				-- ['_'] = 'actions.open_cwd',
				-- ['`'] = 'actions.cd',
				-- ['~'] = 'actions.tcd',
				-- ['gs'] = 'actions.change_sort',
				-- ['gx'] = 'actions.open_external',
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name)
					return name == '..'
				end,
			},
		}
	end,
}
