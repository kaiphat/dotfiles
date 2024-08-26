vim.g.codeium_idle_delay = 20
vim.g.codeium_disable_bindings = 1
vim.g.codeium_enabled = true

return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'BufEnter',
		enabled = true,
		config = function()
			require('copilot').setup {
				panel = {
					enabled = false,
					keymap = {
						-- open = "<C-e>"
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = '<C-g>',
						accept_word = false,
						accept_line = false,
						next = '<C-q>',
						prev = '<M-[>',
						dismiss = '<C-]>',
					},
				},
				filetypes = {
					markdown = true,
				},
				server_opts_overrides = {
					settings = {
						editor = {
							delayCompletions = 100,
						},
						advanced = {
							inlineSuggestCount = 3,
						},
					},
				},
			}
		end,
	},

	{
		'CopilotC-Nvim/CopilotChat.nvim',
		keys = {
			{
				'<leader>cc',
				function()
					vim.api.nvim_input ':CopilotChat '
				end,
			},
		},
		opts = {},
	},

	{
		'Exafunction/codeium.nvim',
		enabled = false,
		evant = { 'InsertEnter' },
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp',
		},
		config = function()
			require('codeium').setup {}
		end,
	},

	{
		'Exafunction/codeium.vim',
		enabled = false,
		event = 'BufEnter',
		keys = {
			{
				'<C-g>',
				function()
					return vim.fn['codeium#Accept']()
				end,
				mode = 'i',
				expr = true,
				silent = true,
			},
			{
				'<C-q>',
				function()
					return vim.fn['codeium#CycleCompletions'](1)
				end,
				mode = 'i',
				expr = true,
				silent = true,
			},
		},
	},

	{
		'codota/tabnine-nvim',
		build = './dl_binaries.sh',
		enabled = false,
		config = function()
			require('tabnine').setup {
				disable_auto_comment = true,
				accept_keymap = '<C-g>',
				dismiss_keymap = '<C-]>',
				debounce_ms = 300,
				codelens_enabled = true,
				suggestion_color = { gui = '#808080', cterm = 244 },
				exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
				log_file_path = nil, -- absolute path to Tabnine log file
				ignore_certificate_errors = false,
			}
		end,
	},
}
