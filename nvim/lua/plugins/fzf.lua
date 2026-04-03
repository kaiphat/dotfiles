return {
	'ibhagwan/fzf-lua',
	dependencies = { 'nvim-mini/mini.icons' },
	enabled = false,
	event = 'VeryLazy',
	config = function()
		local fzf = require 'fzf-lua'

		__.picker = require 'fzf-lua'

		fzf.register_ui_select()

		fzf.setup {
			fzf_bin = 'sk',
			fzf_opts = {
				['--info'] = 'inline-right',
				['--ansi'] = true,
				['--layout'] = 'reverse',
				['--border'] = 'none',
				['--height'] = '100%',
				['--prompt'] = __.constants.icons.BRACKET,
				['--pointer'] = __.constants.icons.ARROW,
				['--marker'] = __.constants.icons.BRACKET,
				['--no-scrollbar'] = '',
				['--header'] = ' ',
				['--cycle'] = '',
				['--padding'] = '1',
				['--algo'] = 'arinae',
			},

			fzf_colors = {
				true,
				-- ['fg'] = { 'fg', 'Comment' },
				-- ['fg+'] = { 'fg', 'Comment' },
				-- ['pointer'] = { 'fg', '@label' },
				-- ['info'] = { 'fg', '@label' },
				-- ['query'] = { 'fg', '@label' },
				['bg+'] = { 'bg', { 'CursorLine', 'Normal' } },
				-- ['hl'] = { 'fg', '@label' },
				-- ['hl+'] = { 'fg', '@label' },
				['gutter'] = '-1',
				-- ['info'] = { 'fg', 'PreProc' },
				-- ['prompt'] = { 'fg', 'Conditional' },
				['header'] = { 'fg', 'Comment' },
			},

			winopts = {
				border = 'noborder',
				preview = {
					default = 'builtin',
					border = 'rounded',
					wrap = false,
					hidden = false,
					vertical = 'down:60%',
					horizontal = 'right:60%',
					layout = 'vertical',
					flip_columns = 120,
					title = true,
					title_pos = 'center',
					scrollbar = false,
					scrolloff = '-2',
					delay = 20,
					winopts = {
						number = false,
						relativenumber = false,
						cursorline = true,
						cursorlineopt = 'both',
						cursorcolumn = false,
						signcolumn = 'no',
						list = false,
						foldenable = false,
						foldmethod = 'manual',
					},
				},
			},

			keymap = {
				builtin = {
					['<C-d>'] = 'preview-page-down',
					['<C-u>'] = 'preview-page-up',
				},
				fzf = {
					['ctrl-e'] = 'abort',
				},
			},

			defaults = {
				prompt = '  ' .. __.constants.icons.BRACKET .. ' ',
				file_icons = 'mini',
				cwd_prompt = false,
				no_header_i = true,
			},

			files = {
				formatter = 'path.filename_first',
			},

			grep = {
				rg_opts = '--column -n --no-heading --color=always --ignore-case --max-columns=4096 -U -e',
			},
		}
	end,

	keys = {
		{
			'<leader>p',
			function()
				vim.cmd 'FzfLua'
			end,
		},
		{
			'<leader>fj',
			function()
				require('fzf-lua').files()
			end,
		},
		{
			'<leader>ec',
			function()
				require('fzf-lua').files {
					cwd = '~/dotfiles',
				}
			end,
		},
		{
			'<leader>fl',
			function()
				require('fzf-lua').live_grep()
			end,
		},
		{
			'<leader>fi',
			function()
				require('fzf-lua').lsp_references()
			end,
		},
		{
			'<leader>fm',
			function()
				require('fzf-lua').helptags()
			end,
		},
		{
			'<leader>fr',
			function()
				require('fzf-lua').blines()
			end,
		},
		{
			'<leader>fp',
			function()
				require('fzf-lua').resume()
			end,
		},
		{
			'<leader>fo',
			function()
				require('fzf-lua').oldfiles()
			end,
		},
		{
			'<leader>fb',
			function()
				require('fzf-lua').buffers()
			end,
		},
		{
			'<leader>fw',
			function()
				require('fzf-lua').lsp_workspace_symbols()
			end,
		},
	},
}
