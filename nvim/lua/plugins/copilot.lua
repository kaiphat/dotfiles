return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		enabled = true,
		config = function()
			require('copilot').setup {
				suggestion = {
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
			}
		end,
	},

	{
		'CopilotC-Nvim/CopilotChat.nvim',
		keys = {
			{
				'<leader>cc',
				function()
					vim.api.nvim_input ':CopilotChatVisual '
				end,
			},
		},
		opts = {},
	},
}
