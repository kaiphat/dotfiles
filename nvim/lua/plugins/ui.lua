__.add_plugin {
	'folke/which-key.nvim',
	event = 'BufReadPost',
	keys = {
		{
			'<leader>?',
			function(_)
				_.show { global = false }
			end,
			desc = 'Buffer Local Keymaps (which-key)',
		},
	},
	opts = {
		preset = 'helix',
		delay = 800,
	},
}

__.add_plugin {
	'kevinhwang91/nvim-hlslens',
	event = 'BufReadPost',
	config = function(_)
		_.setup {
			nearest_only = true,
		}

		local opts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap(
			'n',
			'n',
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			opts
		)
		vim.api.nvim_set_keymap(
			'n',
			'N',
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			opts
		)
		vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
		vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
	end,
}
