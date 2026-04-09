__.add_plugin {
	'CopilotC-Nvim/CopilotChat.nvim',
	deps = {
		'plenary',
		'render-markdown',
	},
	keys = {
		{
			'<leader>cc',
			function()
				vim.api.nvim_input ':CopilotChat '
			end,
		},
	},
	opts = {
		headers = {
			user = 'Me',
			assistant = '🤖 Copilot',
			tool = '🔧 Tool',
		},
		highlight_headers = false,
		separator = '---',
		error_header = '> [!ERROR] Error',
		show_folds = false,
		mappings = {
			reset = { normal = '<C-l>ll', insert = '<C-l>ll' },
		},
	},
}

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'CopilotChat' and (kind == 'install' or kind == 'update') then
			vim.system({ 'make', 'tiktoken' }, { cwd = ev.data.path })
		end
	end,
})

__.add_plugin {
	'zbirenbaum/copilot.lua',
	name = 'copilot',
	cmds = { 'Copilot' },
	event = 'InsertEnter',
	opts = {
		copilot_node_command = vim.fn.expand '$HOME' .. '/.local/state/fnm_multishells/21008_1746545824329/bin/node', -- Node.js version must be > 20
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
	},
}
