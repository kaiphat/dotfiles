return {
	'stevearc/oil.nvim',
	keys = {
		{ '<leader>o', function() require('oil').open() end },
		{ '<leader>O', function() require('oil').open(vim.loop.cwd()) end },
	},
	config = function()
		require('oil').setup {
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = false,

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
			},
		}
	end,
}
