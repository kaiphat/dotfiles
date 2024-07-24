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
}
