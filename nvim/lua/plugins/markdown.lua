__.add_plugin {
	'MeanderingProgrammer/render-markdown.nvim',
	-- TODO implement fyletype load
	deps = {
		'nvim-treesitter',
		'mini.icons',
	},
	load = function(_)
		vim.treesitter.language.register('markdown', 'copilot-chat')

		_.setup {
			file_types = { 'markdown', 'copilot-chat' },
			heading = {
				sign = false,
				icons = { '◇ ', '◇ ', '◇ ', '◇ ', '◇ ', '◇ ' },
			},
			code = {
				sign = false,
				style = 'full',
				width = 'full',
				border = 'thick',
				language = false,
				language_icon = false,
			},
			bullet = {
				icons = { '•', '◦', '■', '◇ ' },
			},
			completions = {
				lsp = {
					enabled = true,
				},
			},
			dash = {
				icon = '─',
			},
		}
	end,
}
