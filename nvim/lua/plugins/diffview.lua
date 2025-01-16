return {
	'sindrets/diffview.nvim',
	enabled = false,
	cmd = {
		'DiffviewOpen',
		'DiffviewFileHistory',
	},
	keys = {
		{ '<leader>gv', ':DiffviewOpen<cr>' },
		{ '<leader>gh', ':DiffviewFileHistory<cr>' },
	},

	config = function()
		require('diffview').setup {
			diff_binaries = false,
			enhanced_diff_hl = false, -- Set up hihglights in the hooks instead
			git_cmd = { 'git' },
			use_icons = true,
			show_help_hints = false,
			view = {
				default = {
					winbar_info = false,
				},
				merge_tool = {
					layout = 'diff3_mixed',
					disable_diagnostics = true,
					winbar_info = true,
				},
				file_history = {
					winbar_info = false,
				},
			},
			file_panel = {
				listing_style = 'tree',
				tree_options = {
					flatten_dirs = true,
					folder_statuses = 'only_folded',
				},
				win_config = {
					position = 'left',
					width = 35,
				},
			},
			file_history_panel = {
				log_options = {
					git = {
						single_file = {
							diff_merges = 'combined',
							follow = true,
						},
						multi_file = {
							diff_merges = 'first-parent',
						},
					},
				},
				win_config = {
					position = 'bottom',
					height = 16,
				},
			},
			hooks = {
				---@diagnostic disable-next-line: unused-local
				diff_buf_win_enter = function(bufnr, winid, ctx)
					-- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on the right.
					if ctx.layout_name:match '^diff2' then
						if ctx.symbol == 'a' then
							vim.opt_local.winhl = table.concat({
								'DiffAdd:DiffviewDiffAddAsDelete',
								'DiffDelete:DiffviewDiffDelete',
								'DiffChange:DiffAddAsDelete',
								'DiffText:DiffDeleteText',
							}, ',')
						elseif ctx.symbol == 'b' then
							vim.opt_local.winhl = table.concat({
								'DiffDelete:DiffviewDiffDelete',
								'DiffChange:DiffAdd',
								'DiffText:DiffAddText',
							}, ',')
						end
					end
				end,
			},
			default_args = {
				DiffviewOpen = {},
				DiffviewFileHistory = { '%' },
			},
		}
	end,
}
