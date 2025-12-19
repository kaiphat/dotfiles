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
				require('oil').open(vim.uv.cwd())
			end,
		},
	},
	enabled = true,
	config = function()
		vim.api.nvim_create_autocmd('FileType', {
			group = kaiphat.utils.create_augroup 'oil',
			pattern = 'oil',
			callback = function(event)
				local oil = require 'oil'

				vim.api.nvim_buf_set_keymap(event.buf, 'n', '<C-j>', 'j', {})
				vim.api.nvim_buf_set_keymap(event.buf, 'n', '<C-k>', 'k', {})
				vim.keymap.set('n', '<C-y>', function()
					local entry = oil.get_cursor_entry()
					local dir = oil.get_current_dir()
					if not entry or not dir then
						return
					end
					local relpath = vim.fn.fnamemodify(dir .. entry.name, ':.')

					vim.fn.setreg('+', relpath)

					print('Path yanked: ' .. relpath)
				end, { buffer = event.buf })
			end,
		})

		require('oil').setup {
			watch_for_changes = true,
			delete_to_trash = true,
			columns = { 'icon' },
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,

			lsp_file_methods = {
				autosave_changes = true,
			},

			cleanup_delay_ms = false,
			use_default_keymaps = false,
			keymaps = {
				['<C-l>'] = 'actions.select',
				['<CR>'] = 'actions.select_vsplit',
				['<C-p>'] = 'actions.preview',
				['<C-e>'] = 'actions.close',
				['<C-h>'] = 'actions.parent',
				['<C-r>'] = 'actions.refresh',
				-- ['g.'] = 'actions.toggle_hidden',
				-- ['g\\'] = 'actions.toggle_trash',
				-- ['g?'] = 'actions.show_help',
				-- ['<C-h>'] = 'actions.select_split',
				-- ['<C-t>'] = 'actions.select_tab',
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
