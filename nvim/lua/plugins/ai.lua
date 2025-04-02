vim.g.codeium_idle_delay = 20
vim.g.codeium_disable_bindings = 1
vim.g.codeium_enabled = true

return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'BufEnter',
		enabled = false,
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
					hide_during_completion = false,
					debounce = 75,
					keymap = {
						accept = '<C-e>',
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
		enabled = true,
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
		'monkoose/neocodeium',
		event = 'BufEnter',
		enabled = false,
		config = function()
			local neocodeium = require 'neocodeium'

			neocodeium.setup {
				show_label = false,
				silent = true,
				max_lines = -1,
			}

			vim.keymap.set('i', '<C-g>', neocodeium.accept)
			vim.keymap.set('i', '<C-q>', neocodeium.cycle_or_complete)
		end,
	},
}
