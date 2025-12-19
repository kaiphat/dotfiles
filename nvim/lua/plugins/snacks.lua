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
	'pnpm-lock.yaml',
}

local grep_exclude = kaiphat.utils.concat(grep_always_excludes, {
	'data/',
	'.data/',
	'test/',
	'tests/',
	'__tests__/',
	'**/__mocks__/*',
	'*.log',
	'.gitignore',
	'*.md',
	'*.json',
})

local function open_commit(picker, item)
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
end

return {
	'folke/snacks.nvim',
	priority = 950,
	lazy = false,
	event = 'VeryLazy',
	enabled = true,
	keys = {
		-- lazygit
		{
			'<leader>p',
			function()
				Snacks.picker()
			end,
		},
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
				Snacks.picker.smart {}
				-- Snacks.picker.files {
				-- 	exclude = {
				-- 		'test',
				-- 		'__tests__',
				-- 	},
				-- }
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
				-- TODO try to use simple search instead of regexp and add mapping to enable regexp
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
				Snacks.picker.git_grep_hunks {}
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
					filter = {
						filter = function(item)
							for _, exclude in ipairs { 'test' } do
								local found = item.file:find(exclude, 1, true)

								if found then
									return false
								end
							end

							for _, exclude in ipairs { 'import' } do
								local found = item.line:find(exclude, 1, true)

								if found then
									return false
								end
							end

							return true
						end,
					},
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
		-- not working with ts lsp
		-- working with vtsls
		-- {
		-- 	'<leader>fw',
		-- 	function()
		-- 		Snacks.picker.lsp_workspace_symbols {
		-- 			filter = {
		-- 				default = true,
		-- 			},
		-- 		}
		-- 	end,
		-- },
		{
			'<leader>fr',
			function()
				Snacks.picker.lines {}
				--
				-- local curr_path = kaiphat.utils.get_full_path()
				--
				-- Snacks.picker.grep {
				-- 	buffers = true,
				-- 	transform = function(item)
				-- 		local path = item.cwd and vim.fn.fnamemodify(item.cwd .. '/' .. item.file, ':p') or item.file
				--
				-- 		return curr_path == path
				-- 	end,
				-- 	layout = {
				-- 		preview = 'main',
				-- 		preset = 'ivy',
				-- 	},
				-- 	on_show = function(picker)
				-- 		local cursor = vim.api.nvim_win_get_cursor(picker.main)
				-- 		local info = vim.api.nvim_win_call(picker.main, vim.fn.winsaveview)
				-- 		picker.list:view(cursor[1], info.topline)
				-- 		picker:show_preview()
				-- 	end,
				-- 	sort = { fields = { 'score:desc', 'idx' } },
				-- 	jump = { match = true },
				-- 	main = { current = true },
				-- }
			end,
		},
		{
			'<leader>fs',
			function()
				Snacks.picker.lsp_symbols {
					-- tree = false,
					-- workspace = true,
					filter = {
						default = {
							'Variable',
							'Class',
							'Constructor',
							'Enum',
							'Field',
							'Function',
							'Interface',
							'Method',
							'Module',
							'Namespace',
							'Package',
							'Property',
							'Struct',
							'Trait',
						},
					},
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
					confirm = open_commit,
				}
			end,
		},
		{
			'<leader>fq',
			function()
				Snacks.picker.git_log_line {
					confirm = open_commit,
				}
			end,
		},
		{
			'<leader>fn',
			function()
				Snacks.picker.diagnostics {}
			end,
		},
		{
			'<leader>fa',
			function()
				Snacks.picker.lsp_symbols {
					layout = {
						preset = 'vscode',
						hidden = {},
						preview = 'main',
					},
				}
			end,
		},
		-- {
		-- 	'<leader>fe',
		-- 	function()
		-- 		Snacks.explorer {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fd',
		-- 	function()
		-- 		-- todo: use base option
		-- 		Snacks.picker.git_diff {
		-- 			finder = function(opts, ctx)
		-- 				local file, line
		-- 				local header, hunk = {}, {}
		-- 				local header_len = 4
		-- 				local finder = require('snacks.picker.source.proc').proc({
		-- 					opts,
		-- 					{
		-- 						cmd = 'git',
		-- 						args = {
		-- 							'-c',
		-- 							'core.quotepath=false',
		-- 							'--no-pager',
		-- 							'diff',
		-- 							'origin/master...HEAD',
		-- 							'--no-color',
		-- 							'--no-ext-diff',
		-- 						},
		-- 					},
		-- 				}, ctx)
		-- 				return function(cb)
		-- 					local function add()
		-- 						if file and line and #hunk > 0 then
		-- 							local diff = table.concat(header, '\n') .. '\n' .. table.concat(hunk, '\n')
		-- 							cb {
		-- 								text = file .. ':' .. line,
		-- 								diff = diff,
		-- 								file = file,
		-- 								pos = { line, 0 },
		-- 								preview = { text = diff, ft = 'diff', loc = false },
		-- 							}
		-- 						end
		-- 						hunk = {}
		-- 					end
		-- 					finder(function(proc_item)
		-- 						local text = proc_item.text
		-- 						if text:find('diff', 1, true) == 1 then
		-- 							add()
		-- 							file = text:match '^diff .* a/(.*) b/.*$'
		-- 							header = { text }
		-- 							header_len = 4
		-- 						elseif file and #header < header_len then
		-- 							if text:find '^deleted file' then
		-- 								header_len = 5
		-- 							end
		-- 							header[#header + 1] = text
		-- 						elseif text:find('@', 1, true) == 1 then
		-- 							add()
		-- 							-- Hunk header
		-- 							-- @example "@@ -157,20 +157,6 @@ some content"
		-- 							line = tonumber(string.match(text, '@@ %-.*,.* %+(.*),.* @@'))
		-- 							hunk = { text }
		-- 						elseif #hunk > 0 then
		-- 							hunk[#hunk + 1] = text
		-- 						else
		-- 							error('unexpected line: ' .. text)
		-- 						end
		-- 					end)
		-- 					add()
		-- 				end
		-- 			end,
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
						height = 0.9,
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
					win = {
						input = {
							keys = {
								-- ['o'] = {
								-- 	'explorer_add',
								-- 	mode = { 'i', 'n' },
								-- },
							},
						},
						list = {
							keys = {
								['o'] = {
									'explorer_add',
									mode = { 'i', 'n' },
								},
								['<Tab>'] = {
									'select',
									mode = { 'i', 'n' },
								},
							},
						},
					},
					actions = {
						select = function(picker)
							picker.list:select()
						end,
					},
					layout = {
						preset = 'sidebar',
						layout = {
							width = 55,
						},
					},
				},

				git_grep_hunks = {
					supports_live = false,
					format = function(item, picker)
						local file_format = Snacks.picker.format.file(item, picker)
						vim.api.nvim_set_hl(0, 'SnacksPickerGitGrepLineNew', { link = 'Added' })
						vim.api.nvim_set_hl(0, 'SnacksPickerGitGrepLineOld', { link = 'Removed' })
						if item.sign == '+' then
							file_format[#file_format - 1][2] = 'SnacksPickerGitGrepLineNew'
						else
							file_format[#file_format - 1][2] = 'SnacksPickerGitGrepLineOld'
						end
						return file_format
					end,
					finder = function(_, ctx)
						local success, git_root = pcall(kaiphat.utils.get_git_root)

						if not success then
							vim.notify 'Not a git repository'
							return
						end

						local hcount = 0
						local header = {
							file = '',
							old = { start = 0, count = 0 },
							new = { start = 0, count = 0 },
						}

						local sign_count = 0

						return require('snacks.picker.source.proc').proc(
							ctx:opts {
								cmd = 'git',
								args = { 'diff', '--unified=0' },
								transform = function(item)
									local line = item.text
									-- [[Header]]
									if line:match '^diff' then
										hcount = 3
									elseif hcount > 0 then
										if hcount == 1 then
											local git_root_relative_path = line:sub(7)
											local full_path =
												vim.fn.fnamemodify(git_root .. '/' .. git_root_relative_path, ':p')
											header.file = full_path
										end
										hcount = hcount - 1
									elseif line:match '^@@' then
										local parts = vim.split(line:match '@@ ([^@]+) @@', ' ')
										local old_start, old_count = parts[1]:match '-(%d+),?(%d*)'
										local new_start, new_count = parts[2]:match '+(%d+),?(%d*)'
										header.old.start, header.old.count =
											tonumber(old_start), tonumber(old_count) or 1
										header.new.start, header.new.count =
											tonumber(new_start), tonumber(new_count) or 1
										sign_count = 0
									-- [[Body]]
									elseif not line:match '^[+-]' then
										sign_count = 0
									elseif line:match '^[+-]%s*$' then
										sign_count = sign_count + 1
									else
										item.sign = line:sub(1, 1)
										vim.print(header)
										item.file = header.file
										item.line = line:sub(2)
										if item.sign == '+' then
											item.pos = { header.new.start + sign_count, 0 }
											sign_count = sign_count + 1
										else
											item.pos = { header.new.start, 0 }
											sign_count = 0
										end
										return true
									end
									return false
								end,
							},
							ctx
						)
					end,
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

		scope = {
			enabled = false,
		},

		image = {
			enabled = true,
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
			enabled = false,
			replace_netrw = true,
		},
	},
}
