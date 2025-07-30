local grep_always_excludes = {
	'.git/',
	'dist/',
	'node_modules/',
	'build/',
	'docker_volumes_data/',
	'yarn.lock',
	'Cargo.lock',
	'coverage/',
	'package-lock.json',
}

local grep_exclude = kaiphat.utils.concat(grep_always_excludes, {
	'data/',
	'.data/',
	'test/',
	'tests/',
	'**/__tests__/*',
	'**/__mocks__/*',
	'*.log',
	'.gitignore',
	'*.md',
	'*.json',
})

return {
	'folke/snacks.nvim',
	priority = 2000,
	lazy = false,
	event = 'VeryLazy',
	enabled = true,
	keys = {
		-- lazygit
		{
			'<leader>gl',
			function()
				Snacks.lazygit()
			end,
		},
		{
			'<leader>gL',
			function()
				Snacks.lazygit.log_file()
			end,
		},

		-- picker
		{
			'<leader>fj',
			function()
				Snacks.picker.files {
					exclude = {
						'/test',
					},
				}
			end,
		},
		{
			'<leader>fJ',
			function()
				Snacks.picker.files {
					cwd = kaiphat.utils.get_current_dir(),
					ignored = true,
					hidden = true,
				}
			end,
		},
		{
			'<leader>es',
			function()
				Snacks.picker.files {
					ignored = true,
					hidden = true,
					cwd = '~/secrets',
				}
			end,
		},
		{
			'<leader>ec',
			function()
				Snacks.picker.files {
					ignored = true,
					hidden = true,
					cwd = '~/dotfiles',
				}
			end,
		},
		{
			'<leader>en',
			function()
				Snacks.picker.files {
					ignored = true,
					hidden = true,
					cwd = '~/notes',
				}
			end,
		},
		{
			'<leader>dj',
			function()
				Snacks.picker.files {}
			end,
		},
		{
			'<leader>dJ',
			function()
				Snacks.picker.files {
					ignored = true,
					hidden = true,
				}
			end,
		},

		{
			'<leader>fl',
			function()
				Snacks.picker.grep {
					exclude = grep_exclude,
				}
			end,
		},
		{
			'<leader>dl',
			function()
				Snacks.picker.grep {
					exclude = grep_always_excludes,
				}
			end,
		},
		{
			'<leader>fL',
			function()
				Snacks.picker.grep {
					cwd = kaiphat.utils.get_current_dir(),
				}
			end,
		},
		{
			'<leader>dL',
			function()
				Snacks.picker.grep {
					args = { '-U' },
				}
			end,
		},
		{
			'<leader>fp',
			function()
				Snacks.picker.resume()
			end,
		},
		{
			'<leader>fo',
			function()
				Snacks.picker.recent {
					sort = {
						fields = { 'idx' },
					},
					matcher = {
						fuzzy = false,
						filename_bonus = false,
						file_pos = false,
						cwd_bonus = false,
						frecency = false,
						history_bonus = true,
					},
				}
			end,
		},
		{
			'<leader>fb',
			function()
				Snacks.picker.buffers {}
			end,
		},
		{
			'<leader>fg',
			function()
				Snacks.picker.git_status {}
			end,
		},
		{
			'<leader>fh',
			function()
				Snacks.picker.grep_word {
					exclude = grep_exclude,
				}
			end,
			mode = { 'n', 'v' },
		},
		{
			'<leader>dh',
			function()
				Snacks.picker.grep_word {
					exclude = grep_always_excludes,
				}
			end,
			mode = { 'n', 'v' },
		},
		{
			'<leader>fi',
			function()
				Snacks.picker.lsp_references {
					include_declaration = false,
					pattern = '!import !test/ ',
					jump = { tagstack = true, reuse_win = false },
				}
			end,
		},
		{
			'<leader>fI',
			function()
				Snacks.picker.lsp_implementations {
					jump = { tagstack = true, reuse_win = false },
				}
			end,
		},
		{
			'<leader>di',
			function()
				Snacks.picker.lsp_references {
					include_declaration = false,
					jump = { tagstack = true, reuse_win = false },
				}
			end,
		},
		{
			'<leader>fw',
			function()
				Snacks.picker.lsp_workspace_symbols {
					filter = {
						default = true,
					},
				}
			end,
		},
		{
			'<leader>fe',
			function()
				Snacks.picker.lsp_symbols {
					-- tree = false,
					-- workspace = true,
					-- filter = {
					-- 	default = {
					-- 		'Variable',
					-- 		'Class',
					-- 		'Constructor',
					-- 		'Enum',
					-- 		'Field',
					-- 		'Function',
					-- 		'Interface',
					-- 		'Method',
					-- 		'Module',
					-- 		'Namespace',
					-- 		'Package',
					-- 		'Property',
					-- 		'Struct',
					-- 		'Trait',
					-- 	},
					-- },
				}
			end,
		},
		{
			'<leader>fm',
			function()
				Snacks.picker.help()
			end,
		},
		{
			'<leader>fc',
			function()
				Snacks.picker.git_log_file {
					confirm = function(picker, item)
						local file = kaiphat.utils.exec_nu(
							'nu -l ~/dotfiles/nvim/lua/scripts/open_commit.nu %s %s %s',
							item.cwd,
							item.file,
							item.commit
						)

						if vim.trim(file) == '' then
							print 'File not found in the commit'
							return
						end

						picker:close()
						vim.cmd 'vs'
						vim.schedule(function()
							vim.cmd('e ' .. file)
						end)
					end,
				}
			end,
		},
		{
			'<leader>fd',
			function()
				Snacks.picker.git_diff {
					finder = function(opts, ctx)
						local file, line
						local header, hunk = {}, {}
						local header_len = 4
						local finder = require('snacks.picker.source.proc').proc({
							opts,
							{
								cmd = 'git',
								args = {
									'-c',
									'core.quotepath=false',
									'--no-pager',
									'diff',
									'origin/master...HEAD',
									'--no-color',
									'--no-ext-diff',
								},
							},
						}, ctx)
						return function(cb)
							local function add()
								if file and line and #hunk > 0 then
									local diff = table.concat(header, '\n') .. '\n' .. table.concat(hunk, '\n')
									cb {
										text = file .. ':' .. line,
										diff = diff,
										file = file,
										pos = { line, 0 },
										preview = { text = diff, ft = 'diff', loc = false },
									}
								end
								hunk = {}
							end
							finder(function(proc_item)
								local text = proc_item.text
								if text:find('diff', 1, true) == 1 then
									add()
									file = text:match '^diff .* a/(.*) b/.*$'
									header = { text }
									header_len = 4
								elseif file and #header < header_len then
									if text:find '^deleted file' then
										header_len = 5
									end
									header[#header + 1] = text
								elseif text:find('@', 1, true) == 1 then
									add()
									-- Hunk header
									-- @example "@@ -157,20 +157,6 @@ some content"
									line = tonumber(string.match(text, '@@ %-.*,.* %+(.*),.* @@'))
									hunk = { text }
								elseif #hunk > 0 then
									hunk[#hunk + 1] = text
								else
									error('unexpected line: ' .. text)
								end
							end)
							add()
						end
					end,
				}
			end,
		},
		-- {
		-- 	'<leader>e',
		-- 	function()
		-- 		Snacks.picker.explorer {
		-- 			cwd = kaiphat.utils.get_current_dir(),
		-- 			follow_file = true,
		-- 			matcher = {},
		-- 		}
		-- 	end,
		-- },
	},
	opts = {
		lazygit = {
			configure = false,
			win = {
				style = 'lazygit',
			},
			config = {
				os = nil,
			},
		},

		picker = {
			prompt = ' ' .. kaiphat.constants.icons.BRACKET .. ' ',
			ui_select = true,
			formatters = {
				file = {
					filename_first = true, -- display filename before the file path
					truncate = 100,
				},
			},
			matcher = {
				smartcase = false,
				ignorecase = true,
				filename_bonus = true,
				file_pos = false,

				cwd_bonus = false,
				frecency = true,
				history_bonus = true,
			},
			layouts = {
				custom = {
					layout = {
						backdrop = false,
						width = function()
							local c = vim.o.columns
							if c > 160 then
								return 0.7
							else
								return 0.9
							end
						end,
						min_width = 80,
						height = 0.8,
						min_height = 30,
						box = 'vertical',
						border = 'none',
						title = '{title} {live} {flags}',
						title_pos = 'center',
						{
							win = 'input',
							height = 1,
							border = 'rounded',
						},
						{ win = 'list', height = 15, border = 'hpad' },
						{ win = 'preview', border = 'rounded' },
					},
				},
			},
			layout = {
				preset = 'custom',
			},
			win = {
				input = {
					keys = {
						['<c-e>'] = { 'close', mode = 'i' },
						['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
						['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
						['<c-n>'] = { 'history_forward', mode = { 'i', 'n' } },
						['<c-p>'] = { 'history_back', mode = { 'i', 'n' } },
					},
				},
				preview = {
					wo = {
						number = false,
						relativenumber = false,
						signcolumn = 'no',
						foldcolumn = '1',
						foldenable = false,
					},
				},
			},
			previewers = {
				git = {
					native = false, -- use native (terminal) or Neovim for previewing git diffs and commits
				},
			},
			sources = {
				explorer = {
					layout = {
						preset = 'sidebar',
					},
				},
			},
		},

		indent = {
			enabled = false,
			indent = {
				enabled = true,
				char = kaiphat.constants.icons.VERTICAL_LINE_1,
			},

			animate = {
				enabled = false,
			},

			scope = {
				enabled = false,
			},
		},

		words = {
			enabled = false,
			debounce = 400,
		},

		quickfile = {
			enabled = true,
		},

		bigfile = {
			enabled = true,
		},

		explorer = {
			enabled = true,
			replace_netrw = true,
		},
	},
}
