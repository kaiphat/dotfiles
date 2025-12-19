return {
	{
		'folke/noice.nvim',
		enabled = false,
		event = 'VeryLazy',
		config = function()
			local noice = require 'noice'

			local icon = ' ' .. kaiphat.constants.icons.ARROW

			noice.setup {
				views = {
					cmdline_popup = {
						position = {
							row = '40%',
							col = '50%',
						},
						win_options = {
							winhighlight = {
								Normal = 'NormalFloat',
								FloatBorder = 'FloatBorder',
							},
						},
					},

					mini = {
						timeout = 7000,
						win_options = {
							winblend = 0,
						},
						position = {
							row = -2,
							col = '100%',
						},
					},
				},

				cmdline = {
					view = 'cmdline',
					format = {
						cmdline = { title = '', pattern = '^:', icon = icon, lang = 'vim' },
						search_down = {
							title = '',
							kind = 'search',
							pattern = '^/',
							icon = icon,
							lang = 'regex',
						},
						search_up = { title = '', kind = 'search', pattern = '^%?', icon = icon, lang = 'regex' },
						filter = { pattern = '^:%s*!', icon = icon, lang = 'bash' },
						lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
						help = { pattern = '^:%s*h%s+', icon = icon },
						input = { view = 'cmdline' },
					},
				},

				notify = {
					view = 'mini',
				},

				lsp = {
					progress = {
						enabled = true,
						format = 'lsp_progress',
						format_done = 'lsp_progress_done',
						throttle = 1000 / 30, -- frequency to update lsp progress message
						view = 'mini',
					},
					override = {
						['vim.lsp.util.convert_input_to_markdown_lines'] = true,
						['vim.lsp.util.stylize_markdown'] = true,
						['cmp.entry.get_documentation'] = false,
					},
				},

				format = {},

				presets = {
					bottom_search = true,
					long_message_to_split = true,
					lsp_doc_border = true,
					command_palette = false,
					inc_rename = false,
				},

				routes = {
					{
						filter = {
							event = 'msg_show',
							kind = '',
							find = 'written',
						},
						opts = { skip = true },
					},
					{
						view = 'notify',
						filter = {
							event = 'msg_show',
							find = '%d+L, %d+B',
						},
					},
				},

				health = {
					checker = false,
				},
			}
		end,
	},

	{
		'j-hui/fidget.nvim',
		opts = {
			notification = {
				window = {
					x_padding = 0,
					-- border = 'rounded',
				},
			},
		},
	},
}
