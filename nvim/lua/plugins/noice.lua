local ICONS = {
    ARROW = '➜',
    BRACKET = '❯',
}

return {
	'folke/noice.nvim',
	event = 'BufReadPre',
	config = function()
		local noice = require 'noice'

		noice.setup {
			views = {
				cmdline_popup = {
					-- border = {
					--   style = 'none',
					--   padding = { 1, 2 }
					-- },
					position = {
						row = '35%',
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
					win_options = {
						winblend = 0,
					},
				},
			},

			cmdline = {
				format = {
                    cmdline = { pattern = '^:', icon = ICONS.BRACKET, lang = 'vim' },
					search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
					search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
					filter = { pattern = '^:%s*!', icon = ICONS.BRACKET, lang = 'bash' },
					lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
					help = { pattern = '^:%s*h%s+', icon = ' ' },
					input = {}, -- Used by input()
				},
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
						kind = 'search_count',
					},
					opts = { skip = true },
				},
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
