local M = {}

M.always_ignore_patterns = {
	'.git/',
	'dist/',
	'node_modules/',
	'build/',
	'docker_volumes_data/',
	'yarn.lock',
	'Cargo.lock',
	'coverage/'
}

M.ignore_patterns = concat({
	'data/',
	'.data/',
	'test/',
	'tests/',
	'**/__tests__/*',
	'**/__mocks__/*',
	'package-lock.json',
	'*.log',
	'.gitignore',
	'*.md',
}, M.always_ignore_patterns)

return {
	'nvim-telescope/telescope.nvim',
	enabled = false,
	dependencies = {
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-telescope/telescope-ui-select.nvim',
	},
	cmd = 'Telescope',
	keys = {
		{
			'<leader>fb',
			function()
				require('telescope.builtin').buffers {
					ignore_current_buffer = true,
					cwd_only = true,
					sort_lastused = true,
					trim_text = true,
					show_all_buffers = false,
				}
			end,
		},
		{
			'<leader>fo',
			function()
				require('telescope.builtin').oldfiles {
					tiebreak = function(current_entry, existing_entry)
						return current_entry.index < existing_entry.index
					end,
				}
			end,
		},
		{
			'<leader>fp',
			function() require('telescope.builtin').resume {} end,
		},
		{
			'<leader>fi',
			function()
				require('telescope.builtin').lsp_references {
					include_declaration = true,
					include_current_line = false,
					trim_text = true,
					jump_type = 'vsplit',
					fname_width = 50,
					show_line = false,
				}
			end,
		},
		{
			'<leader>fj',
			function()
				require('telescope.builtin').find_files {
					find_command = concat({
						'fd',
						'-t=f',
						'-E=test/',
						'-E=tests/',
						'-E=__tests__/',
					}, map_list(M.always_ignore_patterns, function(pattern) return '-E=' .. pattern end)),
					hidden = false,
					no_ignore = false,
				}
			end,
		},
		{
			'<leader>fJ',
			function()
				require('telescope.builtin').find_files {
                    cwd = require('telescope.utils').buffer_dir(),
					find_command = {
						'fd',
						'-t=f',
					},
					hidden = true,
					no_ignore = true,
				}
			end,
		},
		{
			'<leader>dj',
			function()
				require('telescope.builtin').find_files {
					find_command = concat({
						'fd',
						'-t',
						'f',
					}, map_list(M.always_ignore_patterns, function(pattern) return '-E=' .. pattern end)),
					hidden = true,
					no_ignore = true,
				}
			end,
		},
		{
			'<leader>fl',
			function()
				require('telescope.builtin').live_grep {
					hidden = true,
					disable_coordinates = true,
					additional_args = concat({
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--trim',
						'--hidden',
					}, map_list(M.ignore_patterns, function(pattern) return '-g=!' .. pattern end)),
				}
			end,
		},
		{
			'<leader>fL',
			function()
                require('telescope.builtin').live_grep {
                    cwd = require('telescope.utils').buffer_dir(),
					hidden = true,
					no_ignore = true,
					disable_coordinates = true,
					additional_args = {
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--ignore-case',
						'--trim',
                        '--no-hidden',
                        '--no-ignore',
					}
				}
			end,
		},
		{
			'<leader>f;',
			function()
                require('telescope.builtin').current_buffer_fuzzy_find { }
			end,
		},
		{
			'<leader>fg',
			function()
                require('telescope.builtin').git_status { }
			end,
		},
		{
			'<leader>dl',
			function()
				require('telescope.builtin').live_grep {
					hidden = true,
					disable_coordinates = true,
					additional_args = concat({
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--ignore-case',
						'--trim',
						'--no-hidden',
						'--no-ignore',
					}, map_list(M.always_ignore_patterns, function(pattern) return '-g=!' .. pattern end)),
				}
			end,
		},
		{
			'<leader>fh',
			function()
				require('telescope.builtin').grep_string {
					disable_coordinates = true,
					additional_args = concat({
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--trim',
						'--hidden',
					}, map_list(M.ignore_patterns, function(pattern) return '-g=!' .. pattern end)),
				}
			end,
		},
		{
			'<leader>dh',
			function()
				require('telescope.builtin').grep_string {
					disable_coordinates = true,
					additional_args = concat({
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--ignore-case',
						'--trim',
						'--no-hidden',
						'--no-ignore',
					}, map_list(M.always_ignore_patterns, function(pattern) return '-g=!' .. pattern end)),
				}
			end,
		},
		{
			'<leader>es',
			function()
				require('telescope.builtin').find_files {
					cwd = '~/dotfiles',
					hidden = true,
					find_command = {
						'fd',
						'-t',
						'f',
						'-E=.git/',
					},
				}
			end,
		},
		{
			'<leader>en',
			function()
                require('telescope.builtin').find_files  {
					cwd = '~/notes',
                    hidden = true,
                    find_command = {
                        'fd',
                        '-t',
                        'f',
                        '-E=.git/',
                    },
				}
			end,
		},
	},
	config = function()
		local telescope = require 'telescope'
		local previewers = require 'telescope.previewers'
		local themes = require 'telescope.themes'
		local actions = require 'telescope.actions'

		telescope.setup {
			defaults = {
				vimgrep_arguments = {
					'rg',
				},
				file_ignore_patterns = {},

                prompt_prefix = '  ',
				selection_caret = ' ',
				entry_prefix = ' ',

				initial_mode = 'insert',
				selection_strategy = 'reset',
				sorting_strategy = 'ascending',
				layout_strategy = 'vertical',
				layout_config = {
					prompt_position = 'top',
					horizontal = {
						preview_height = 0.6,
						preview_cutoff = 40,
						width = 0.95,
					},
					vertical = {
						preview_height = 0.6,
						width = function(_, max_columns)
							local max = 160
							local percentage = 0.7
							return math.min(math.floor(percentage * max_columns), max)
						end,
						height = 0.96,
					},
					cursor = {
						width = 50,
						height = 14,
						borderchars = {
							prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
							results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
							preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
						},
					},
				},
				-- has problem with oldfiles sort
                -- file_sorter = sorters.get_fzy_sorter,
                -- generic_sorter = sorters.get_fzy_sorter,
				path_display = { 'truncate' },
				winblend = 0,
				border = {},
				borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
				color_devicons = true,
				use_less = true,
				set_env = { ['COLORTERM'] = 'truecolor' },
				file_previewer = previewers.vim_buffer_cat.new,
				grep_previewer = previewers.vim_buffer_vimgrep.new,
				qflist_previewer = previewers.vim_buffer_qflist.new,
				buffer_previewer_maker = previewers.buffer_previewer_maker,
				results_title = '',
				mappings = {
					i = {
						['<C-w>'] = function() vim.api.nvim_input '<c-s-w>' end,
						['<C-j>'] = actions.move_selection_next,
						['<C-k>'] = actions.move_selection_previous,
						['<C-l>'] = actions.select_default,
						['<C-p>'] = actions.cycle_history_prev,
						['<C-n>'] = actions.cycle_history_next,
					},
				},
			},

			extensions = {
				['ui-select'] = {
					themes.get_cursor(),
				},

				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				},
			},
		}

		telescope.load_extension 'fzf'
		telescope.load_extension 'ui-select'
	end,
}
