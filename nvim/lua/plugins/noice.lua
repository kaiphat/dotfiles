return {
	'folke/noice.nvim',
	enabled = true,
	event = 'VeryLazy',
	dependencies = {
		'MunifTanjim/nui.nvim',
	},
	config = function()
		local noice = require 'noice'

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
				format = {
					cmdline = { title = '', pattern = '^:', icon = ICONS.TRIANGLE, lang = 'vim' },
					search_down = { title = '', kind = 'search', pattern = '^/', icon = ICONS.SEARCH, lang = 'regex' },
					search_up = { title = '', kind = 'search', pattern = '^%?', icon = ICONS.SEARCH, lang = 'regex' },
					filter = { pattern = '^:%s*!', icon = ICONS.TRIANGLE, lang = 'bash' },
					lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
					help = { pattern = '^:%s*h%s+', icon = ICONS.SEARCH },
					input = {}, -- Used by input()
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
					['cmp.entry.get_documentation'] = true,
				},
			},

			format = {},

			presets = {
				bottom_search = false,
				cmdline_output_to_split = false,

				inc_rename = true,
				long_message_to_split = true,
				lsp_doc_border = true,
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
		}
	end,
}
