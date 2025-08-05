local always_ignore_patterns = {
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

local ignore_patterns = kaiphat.utils.merge({
	'data/',
	'.data/',
	'test/',
	'tests/',
	'**/__tests__/*',
	'**/__mocks__/*',
	'*.log',
	'.gitignore',
	'*.md',
}, always_ignore_patterns)

local IGNORE_LEVEL = {
	FULL = 0,
	TEST = 1,
	WITHOUT = 2,
	DIRECTION = 1,
}

local function build_find_cmd(ignore_level)
	local base = 'fd --type f -i'
	local patterns = {}

	if ignore_level == IGNORE_LEVEL.FULL then
		patterns = ignore_patterns
	elseif ignore_level == IGNORE_LEVEL.TEST or ignore_level == IGNORE_LEVEL.DIRECTION then
		patterns = always_ignore_patterns
		base = base .. ' --no-ignore --hidden'
	else
		base = base .. ' --no-ignore --hidden'
	end

	for _, pattern in ipairs(patterns) do
		base = base .. ' --exclude=' .. pattern
	end

	return base
end

local function build_rg_cmd(ignore_level)
	local base = 'rg --column --no-heading --color=never --max-columns=4096 --trim -i --sort=path -n'
	local patterns = {}

	if ignore_level == IGNORE_LEVEL.FULL then
		patterns = ignore_patterns
	elseif ignore_level == IGNORE_LEVEL.TEST or ignore_level == IGNORE_LEVEL.DIRECTION then
		patterns = always_ignore_patterns
		base = base .. ' --no-ignore --hidden'
	else
		base = base .. ' --no-ignore --hidden'
	end

	for _, pattern in ipairs(patterns) do
		base = base .. ' -g=!' .. pattern
	end

	return base .. ' -e'
end

local function build_prompt()
	return '  ' .. kaiphat.constants.icons.BRACKET .. ' '
end

return {
	'ibhagwan/fzf-lua',
	enabled = false,
	cmd = 'FzfLua',
	keys = {
		-- {
		-- 	'<leader>fj',
		-- 	function()
		-- 		require('fzf-lua').files {
		-- 			cmd = build_find_cmd(IGNORE_LEVEL.FULL),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fJ',
		-- 	function()
		-- 		require('fzf-lua').files {
		-- 			cmd = build_find_cmd(IGNORE_LEVEL.WITHOUT),
		-- 			cwd = kaiphat.utils.get_current_dir(),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>dj',
		-- 	function()
		-- 		require('fzf-lua').files {
		-- 			cmd = build_find_cmd(IGNORE_LEVEL.TEST),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>dJ',
		-- 	function()
		-- 		require('fzf-lua').files {
		-- 			cmd = build_find_cmd(IGNORE_LEVEL.WITHOUT),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fl',
		-- 	function()
		-- 		require('fzf-lua').live_grep {
		-- 			cmd = build_rg_cmd(IGNORE_LEVEL.FULL),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>dl',
		-- 	function()
		-- 		require('fzf-lua').live_grep {
		-- 			cmd = build_rg_cmd(IGNORE_LEVEL.TEST),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fL',
		-- 	function()
		-- 		require('fzf-lua').live_grep {
		-- 			cwd = kaiphat.utils.get_current_dir(),
		-- 			cmd = build_rg_cmd(IGNORE_LEVEL.WITHOUT),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>dL',
		-- 	function()
		-- 		require('fzf-lua').live_grep {
		-- 			cmd = build_rg_cmd(IGNORE_LEVEL.WITHOUT),
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fh',
		-- 	function()
		-- 		require('fzf-lua').grep_cword {
		-- 			cmd = build_rg_cmd(IGNORE_LEVEL.FULL),
		-- 		}
		-- 	end,
		-- 	mode = { 'n', 'v' },
		-- },
		-- {
		-- 	'<leader>dh',
		-- 	function()
		-- 		require('fzf-lua').grep_cword {
		-- 			cmd = build_rg_cmd(IGNORE_LEVEL.TEST),
		-- 		}
		-- 	end,
		-- 	mode = { 'n', 'v' },
		-- },
		-- {
		-- 	'<leader>fp',
		-- 	function()
		-- 		require('fzf-lua').resume {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fo',
		-- 	function()
		-- 		require('fzf-lua').oldfiles {
		-- 			include_current_session = true,
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fi',
		-- 	function()
		-- 		require('fzf-lua').lsp_references {
		-- 			file_ignore_patterns = ignore_patterns,
		-- 			ignore_current_line = true,
		-- 			regex_filter = { 'import.*from', exclude = true },
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>di',
		-- 	function()
		-- 		require('fzf-lua').lsp_references {
		-- 			ignore_current_line = true,
		-- 			regex_filter = { 'import.*from', exclude = true },
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fb',
		-- 	function()
		-- 		require('fzf-lua').buffers {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>en',
		-- 	function()
		-- 		require('fzf-lua').files {
		-- 			cmd = build_find_cmd(IGNORE_LEVEL.DIRECTION),
		-- 			cwd = '~/notes',
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>es',
		-- 	function()
		-- 		require('fzf-lua').files {
		-- 			cmd = build_find_cmd(IGNORE_LEVEL.DIRECTION),
		-- 			cwd = '~/dotfiles',
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fe',
		-- 	function()
		-- 		require('fzf-lua').blines {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>de',
		-- 	function()
		-- 		require('fzf-lua').lines {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fg',
		-- 	function()
		-- 		require('fzf-lua').git_status {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fc',
		-- 	function()
		-- 		require('fzf-lua').git_bcommits {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fq',
		-- 	function()
		-- 		require('fzf-lua').lsp_document_symbols {}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>fw',
		-- 	function()
		-- 		require('fzf-lua').lsp_live_workspace_symbols {
		-- 			file_ignore_patterns = ignore_patterns,
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>dw',
		-- 	function()
		-- 		require('fzf-lua').lsp_live_workspace_symbols {
		-- 			file_ignore_patterns = always_ignore_patterns,
		-- 		}
		-- 	end,
		-- },
	},
	config = function()
		local actions = require 'fzf-lua.actions'

		require('fzf-lua').register_ui_select()

		require('fzf-lua').setup {
			-- winopts_fn = function()
			-- 	return {
			-- 		width = vim.o.columns > 190 and 0.5 or 0.8,
			-- 	}
			-- end,
			winopts = {
				-- split         = "belowright new",-- open in a split instead?
				-- "belowright new"  : split below
				-- "aboveleft new"   : split above
				-- "belowright vnew" : split right
				-- "aboveleft vnew   : split left
				-- Only valid when using a float window
				-- (i.e. when 'split' is not defined, default)
				height = 0.85, -- window height
				width = 0.65, -- window width
				row = 0.35, -- window row position (0=top, 1=bottom)
				col = 0.50, -- window col position (0=left, 1=right)
				-- border argument passthrough to nvim_open_win(), also used
				-- to manually draw the border characters around the preview
				-- window, can be set to 'false' to remove all borders or to
				-- 'none', 'single', 'double', 'thicc' (+cc) or 'rounded' (default)
				border = 'noborder',
				-- requires neovim > v0.9.0, passed as is to `nvim_open_win`
				-- can be sent individually to any provider to set the win title
				-- title         = "Title",
				-- title_pos     = "center",    -- 'left', 'center' or 'right'
				fullscreen = false, -- start fullscreen?
				preview = {
					default = 'builtin', -- override the default previewer?
					border = 'single', -- border|noborder, applies only to
					wrap = 'nowrap', -- wrap|nowrap
					hidden = 'nohidden', -- hidden|nohidden
					vertical = 'down:60%', -- up|down:size
					horizontal = 'right:60%', -- right|left:size
					layout = 'vertical', -- horizontal|vertical|flex
					flip_columns = 120, -- #cols to switch to horizontal on flex
					-- Only used with the builtin previewer:
					title = true, -- preview border title (file/buf)?
					title_pos = 'center', -- left|center|right, title alignment
					scrollbar = false, -- `false` or string:'float|border'
					-- float:  in-window floating border
					-- border: in-border chars (see below)
					scrolloff = '-2', -- float scrollbar offset from right
					-- applies only when scrollbar = 'float'
					scrollchars = { '█', '' }, -- scrollbar chars ({ <full>, <empty> }
					-- applies only when scrollbar = 'border'
					delay = 10, -- delay(ms) displaying the preview
					-- prevents lag on fast scrolling
					winopts = { -- builtin previewer window options
						number = false,
						relativenumber = false,
						cursorline = true,
						cursorlineopt = 'both',
						cursorcolumn = false,
						signcolumn = 'no',
						list = false,
						foldenable = false,
						foldmethod = 'manual',
					},
				},
				on_create = function()
					-- called once upon creation of the fzf main window
					-- can be used to add custom fzf-lua mappings, e.g:
					--   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
				end,
				-- called once *after* the fzf interface is closed
				-- on_close = function() ... end
			},
			keymap = {
				-- These override the default tables completely
				-- no need to set to `false` to disable a bind
				-- delete or modify is sufficient
				builtin = {
					-- neovim `:tmap` mappings for the fzf win
					['<F1>'] = 'toggle-help',
					['<F2>'] = 'toggle-fullscreen',
					-- Only valid with the 'builtin' previewer
					['<F3>'] = 'toggle-preview-wrap',
					['<F4>'] = 'toggle-preview',
					-- Rotate preview clockwise/counter-clockwise
					['<F5>'] = 'toggle-preview-ccw',
					['<F6>'] = 'toggle-preview-cw',
					['<S-down>'] = 'preview-page-down',
					['<S-up>'] = 'preview-page-up',
					['<S-left>'] = 'preview-page-reset',
					['<C-d>'] = 'preview-page-down',
					['<C-u>'] = 'preview-page-up',
				},
				fzf = {
					-- ['ctrl-u'] = false,
					-- ["ctrl-u"] = "unix-line-discard",
					['ctrl-f'] = 'half-page-down',
					['ctrl-b'] = 'half-page-up',
					['ctrl-a'] = 'beginning-of-line',
					['ctrl-e'] = 'abort',
					['alt-a'] = 'toggle-all',
					-- Only valid with fzf previewers (bat/cat/git/etc)
					['f3'] = 'toggle-preview-wrap',
					['f4'] = 'toggle-preview',
					['ctrl-d'] = 'preview-page-down',
					['ctrl-u'] = 'preview-page-up',
				},
			},
			actions = {
				-- These override the default tables completely
				-- no need to set to `false` to disable an action
				-- delete or modify is sufficient
				files = {
					-- providers that inherit these actions:
					--   files, git_files, git_status, grep, lsp
					--   oldfiles, quickfix, loclist, tags, btags
					--   args
					-- default action opens a single selection
					-- or sends multiple selection to quickfix
					-- replace the default action with the below
					-- to open all files whether single or multiple
					-- ["default"]     = actions.file_edit,
					['default'] = actions.file_edit_or_qf,
					['ctrl-o'] = actions.file_edit_or_qf,
					['ctrl-s'] = actions.file_split,
					['ctrl-v'] = actions.file_vsplit,
					['ctrl-t'] = actions.file_tabedit,
					['ctrl-q'] = actions.file_sel_to_qf,
					['alt-l'] = actions.file_sel_to_ll,
				},
				buffers = {
					-- providers that inherit these actions:
					--   buffers, tabs, lines, blines
					['default'] = actions.buf_edit,
					['ctrl-s'] = actions.buf_split,
					['ctrl-o'] = actions.buf_edit,
					['ctrl-v'] = actions.buf_vsplit,
					['ctrl-t'] = actions.buf_tabedit,
				},
			},
			fzf_opts = {},
			fzf_tmux_opts = { ['-p'] = '80%,80%', ['--margin'] = '0,0' },
			fzf_colors = {
				['fg'] = { 'fg', 'Comment' },
				['fg+'] = { 'fg', 'Comment' },
				['pointer'] = { 'fg', '@label' },
				['info'] = { 'fg', '@label' },
				['query'] = { 'fg', '@label' },
				['bg+'] = { 'bg', 'Visual' },
				['hl'] = { 'fg', '@label' },
				['hl+'] = { 'fg', '@label' },
				['gutter'] = '-1',
			},
			previewers = {
				cat = {
					cmd = 'cat',
					args = '--number',
				},
				bat = {
					cmd = 'bat',
					args = '--color=always --style=numbers,changes',
					-- uncomment to set a bat theme, `bat --list-themes`
					-- theme           = 'Coldark-Dark',
				},
				head = {
					cmd = 'head',
					args = nil,
				},
				git_diff = {
					-- if required, use `{file}` for argument positioning
					-- e.g. `cmd_modified = "git diff --color HEAD {file} | cut -c -30"`
					cmd_deleted = 'git diff --color HEAD --',
					cmd_modified = 'git diff --color HEAD',
					cmd_untracked = 'git diff --color --no-index /dev/null',
					-- git-delta is automatically detected as pager, set `pager=false`
					-- to disable, can also be set under 'git.status.preview_pager'
				},
				man = {
					-- NOTE: remove the `-c` flag when using man-db
					-- replace with `man -P cat %s | col -bx` on OSX
					cmd = 'man -c %s | col -bx',
				},
				builtin = {
					syntax = true, -- preview syntax highlight?
					syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
					syntax_limit_b = 1024 * 100, -- syntax limit (bytes), 0=nolimit
					limit_b = 1024 * 1024 * 10, -- preview limit (bytes), 0=nolimit
					-- previewer treesitter options:
					-- enable specific filetypes with: `{ enable = { "lua" } }
					-- exclude specific filetypes with: `{ disable = { "lua" } }
					-- disable fully with: `{ enable = false }`
					-- By default, the main window dimensions are calculated as if the
					-- preview is visible, when hidden the main window will extend to
					-- full size. Set the below to "extend" to prevent the main window
					-- from being modified when toggling the preview.
					toggle_behavior = 'default',
					-- Title transform function, by default only displays the tail
					-- title_fnamemodify = function(s) vim.fn.fnamemodify(s, ":t") end,
					-- preview extensions using a custom shell command:
					-- for example, use `viu` for image previews
					-- will do nothing if `viu` isn't executable
					extensions = {
						-- neovim terminal only supports `viu` block output
						['png'] = { 'viu', '-b' },
						-- by default the filename is added as last argument
						-- if required, use `{file}` for argument positioning
						['svg'] = { 'chafa', '{file}' },
						['jpg'] = { 'ueberzug' },
					},
					-- if using `ueberzug` in the above extensions map
					-- set the default image scaler, possible scalers:
					--   false (none), "crop", "distort", "fit_contain",
					--   "contain", "forced_cover", "cover"
					-- https://github.com/seebye/ueberzug
					ueberzug_scaler = 'cover',
					-- Custom filetype autocmds aren't triggered on
					-- the preview buffer, define them here instead
					-- ext_ft_override = { ["ksql"] = "sql", ... },
				},
				-- Code Action previewers, default is "codeaction" (set via `lsp.code_actions.previewer`)
				-- "codeaction_native" uses fzf's native previewer, recommended when combined with git-delta
				codeaction = {
					-- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
					diff_opts = { ctxlen = 3 },
				},
				codeaction_native = {
					diff_opts = { ctxlen = 3 },
					-- git-delta is automatically detected as pager, set `pager=false`
					-- to disable, can also be set under 'lsp.code_actions.preview_pager'
					-- recommended styling for delta
					--pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
				},
			},
			-- PROVIDERS SETUP
			-- use `defaults` (table or function) if you wish to set "global-provider" defaults
			-- for example, disabling file icons globally and open the quickfix list at the top
			defaults = {
				no_header = false, -- hide grep|cwd header?
				no_header_i = true, -- hide interactive header?
				multiprocess = true,
				prompt = build_prompt(),
				file_icons = 'mini',
				live_ast_prefix = false,
				trim_entry = true,
				formatter = 'path.filename_first',
				fzf_args = '--bind=change:first',
				fzf_opts = {
					['-i'] = true,
					['--info'] = 'inline-right',
					['--ansi'] = true,
					['--height'] = '100%',
					['--layout'] = 'reverse',
					['--border'] = 'none',
					['--prompt'] = '❯',
					['--pointer'] = kaiphat.constants.icons.CARET,
					['--marker'] = '❯',
					['--no-scrollbar'] = '',
					['--no-separator'] = '',
					['--header'] = ' ',
					['--cycle'] = '',
				},
			},
			files = {
				-- previewer      = "bat",          -- uncomment to override previewer
				-- (name from 'previewers' table)
				-- set to 'false' to disable
				multiprocess = true, -- run command in a separate process
				git_icons = false, -- show git icons?
				color_icons = true, -- colorize file|git icons
				-- path_shorten   = 1,              -- 'true' or number, shorten path?
				-- executed command priority is 'cmd' (if exists)
				-- otherwise auto-detect prioritizes `fd`:`rg`:`find`
				-- default options are controlled by 'fd|rg|find|_opts'
				-- NOTE: 'find -printf' requires GNU find
				-- cmd            = "find . -type f -printf '%P\n'",
				find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
				rg_opts = '--color=never --files --hidden --follow -g \'!.git\' -i',
				fd_opts = '--color=never --type f --hidden --follow --exclude .git -i',
				-- by default, cwd appears in the header only if {opts} contain a cwd
				-- parameter to a different folder than the current working directory
				-- uncomment if you wish to force display of the cwd as part of the
				-- query prompt string (fzf.vim style), header line or both
				-- cwd_header = true,
				cwd_prompt = false,
				cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
				cwd_prompt_shorten_val = 1, -- shortened path parts length
				toggle_ignore_flag = '--no-ignore', -- flag toggled in `actions.toggle_ignore`
				actions = {},
				fzf_opts = {
					['--history'] = vim.fn.stdpath 'data' .. '/fzf-lua-files-history',
				},
			},
			git = {
				files = {
					cmd = 'git ls-files --exclude-standard',
					multiprocess = true, -- run command in a separate process
					git_icons = true, -- show git icons?
					file_icons = true, -- show file icons?
					color_icons = true, -- colorize file|git icons
					-- force display the cwd header line regardless of your current working
					-- directory can also be used to hide the header when not wanted
					-- cwd_header = true
				},
				status = {
					cmd = 'git -c color.status=false status -su',
					multiprocess = true, -- run command in a separate process
					file_icons = true,
					git_icons = true,
					color_icons = true,
					previewer = 'git_diff',
					-- git-delta is automatically detected as pager, uncomment to disable
					preview_pager = false,
					actions = {
						-- actions inherit from 'actions.files' and merge
						['right'] = { fn = actions.git_unstage, reload = true },
						['left'] = { fn = actions.git_stage, reload = true },
						['ctrl-x'] = { fn = actions.git_reset, reload = true },
					},
					-- If you wish to use a single stage|unstage toggle instead
					-- using 'ctrl-s' modify the 'actions' table as shown below
					-- actions = {
					--   ["right"]   = false,
					--   ["left"]    = false,
					--   ["ctrl-x"]  = { fn = actions.git_reset, reload = true },
					--   ["ctrl-s"]  = { fn = actions.git_stage_unstage, reload = true },
					-- },
				},
				commits = {
					cmd = 'git log --color --pretty=format:\'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset\'',
					preview = 'git show --color {1}',
					-- git-delta is automatically detected as pager, uncomment to disable
					-- preview_pager = false,
					actions = {
						['default'] = actions.git_checkout,
						-- remove `exec_silent` or set to `false` to exit after yank
						['ctrl-y'] = { fn = actions.git_yank_commit, exec_silent = true },
					},
				},
				bcommits = {
					prompt = build_prompt(),
					-- default preview shows a git diff vs the previous commit
					-- if you prefer to see the entire commit you can use:
					--   git show --color {1} --rotate-to={file}
					--   {1}    : commit SHA (fzf field index expression)
					--   {file} : filepath placement within the commands
					cmd = 'git log --color --pretty=format:\'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset\' {file}',
					preview = 'git show --color {1} -- {file}',
					-- git-delta is automatically detected as pager, uncomment to disable
					preview_pager = false,
					actions = {
						['default'] = actions.git_buf_edit,
						['ctrl-s'] = actions.git_buf_split,
						['ctrl-v'] = actions.git_buf_vsplit,
						['ctrl-t'] = actions.git_buf_tabedit,
						['ctrl-y'] = { fn = actions.git_yank_commit, exec_silent = true },
					},
				},
				branches = {
					cmd = 'git branch --all --color',
					preview = 'git log --graph --pretty=oneline --abbrev-commit --color {1}',
					actions = {
						['default'] = actions.git_switch,
					},
				},
				tags = {
					cmd = 'git for-each-ref --color --sort=-taggerdate --format '
						.. '\'%(color:yellow)%(refname:short)%(color:reset) '
						.. '%(color:green)(%(taggerdate:relative))%(color:reset)'
						.. ' %(subject) %(color:blue)%(taggername)%(color:reset)\' refs/tags',
					preview = 'git log --graph --color --pretty=format:\'%C(yellow)%h%Creset '
						.. '%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset\' {1}',
					fzf_opts = { ['--no-multi'] = '' },
					actions = { ['default'] = actions.git_checkout },
				},
				stash = {
					cmd = 'git --no-pager stash list',
					preview = 'git --no-pager stash show --patch --color {1}',
					actions = {
						['default'] = actions.git_stash_apply,
						['ctrl-x'] = { fn = actions.git_stash_drop, reload = true },
					},
					fzf_opts = {
						['--no-multi'] = '',
					},
				},
				icons = {
					['M'] = { icon = 'M', color = 'yellow' },
					['D'] = { icon = 'D', color = 'red' },
					['A'] = { icon = 'A', color = 'green' },
					['R'] = { icon = 'R', color = 'yellow' },
					['C'] = { icon = 'C', color = 'yellow' },
					['T'] = { icon = 'T', color = 'magenta' },
					['?'] = { icon = '?', color = 'magenta' },
					-- override git icons?
					-- ["M"]        = { icon = "★", color = "red" },
					-- ["D"]        = { icon = "✗", color = "red" },
					-- ["A"]        = { icon = "+", color = "green" },
				},
			},
			grep = {
				multiprocess = true, -- run command in a separate process
				git_icons = false, -- show git icons?
				file_icons = true, -- show file icons?
				color_icons = true, -- colorize file|git icons
				-- executed command priority is 'cmd' (if exists)
				-- otherwise auto-detect prioritizes `rg` over `grep`
				-- default options are controlled by 'rg|grep_opts'
				-- cmd            = "rg --vimgrep",
				grep_opts = '--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e',
				rg_opts = '--column --line-number --no-heading --color=always --ignore-case --max-columns=4096 -e',
				-- set to 'true' to always parse globs in both 'grep' and 'live_grep'
				-- search strings will be split using the 'glob_separator' and translated
				-- to '--iglob=' arguments, requires 'rg'
				-- can still be used when 'false' by calling 'live_grep_glob' directly
				rg_glob = true, -- default to glob parsing?
				glob_flag = '--iglob', -- for case sensitive globs use '--glob'
				glob_separator = '%s%-%-', -- query separator pattern (lua): ' --'
				-- advanced usage: for custom argument parsing define
				-- 'rg_glob_fn' to return a pair:
				--   first returned argument is the new search query
				--   second returned argument are additional rg flags
				-- rg_glob_fn = function(query, opts)
				--   ...
				--   return new_query, flags
				-- end,
				actions = {},
				fzf_opts = {
					['--history'] = vim.fn.stdpath 'data' .. '/fzf-lua-grep-history',
				},
			},
			args = {
				prompt = 'Args❯ ',
				files_only = true,
				-- actions inherit from 'actions.files' and merge
				actions = { ['ctrl-x'] = { fn = actions.arg_del, reload = true } },
			},
			oldfiles = {
				cwd_only = false,
				stat_file = true, -- verify files exist on disk
				include_current_session = true, -- include bufs from current session
			},
			buffers = {
				file_icons = true, -- show file icons?
				color_icons = true, -- colorize file|git icons
				sort_lastused = true, -- sort buffers() by last used
				show_unloaded = true, -- show unloaded buffers
				cwd_only = false, -- buffers for the cwd only
				cwd = nil, -- buffers list for a given dir
				actions = {
					-- actions inherit from 'actions.buffers' and merge
					-- by supplying a table of functions we're telling
					-- fzf-lua to not close the fzf window, this way we
					-- can resume the buffers picker on the same window
					-- eliminating an otherwise unaesthetic win "flash"
					['ctrl-x'] = { fn = actions.buf_del, reload = true },
				},
			},
			lines = {
				previewer = 'builtin', -- set to 'false' to disable
				show_unloaded = true, -- show unloaded buffers
				show_unlisted = false, -- exclude 'help' buffers
				no_term_buffers = true, -- exclude 'term' buffers
				fzf_opts = {
					-- do not include bufnr in fuzzy matching
					-- tiebreak by line no.
					-- ['--delimiter'] = '\'[\\]:]\'',
					-- ['--nth'] = '2..',
					['--tiebreak'] = 'index',
					['--tabstop'] = '1',
				},
				-- actions inherit from 'actions.buffers' and merge
				actions = {
					['default'] = actions.buf_edit_or_qf,
					['alt-q'] = actions.buf_sel_to_qf,
					['alt-l'] = actions.buf_sel_to_ll,
				},
			},
			blines = {
				previewer = 'builtin', -- set to 'false' to disable
				show_unlisted = true, -- include 'help' buffers
				no_term_buffers = false, -- include 'term' buffers
				-- start          = "cursor"      -- start display from cursor?
				fzf_opts = {
					-- hide filename, tiebreak by line no.
					['--delimiter'] = '\'[:]\'',
					['--with-nth'] = '2..',
					['--tiebreak'] = 'index',
					['--tabstop'] = '1',
				},
				-- actions inherit from 'actions.buffers' and merge
				actions = {
					['default'] = actions.buf_edit_or_qf,
					['alt-q'] = actions.buf_sel_to_qf,
					['alt-l'] = actions.buf_sel_to_ll,
				},
			},
			quickfix = {
				file_icons = true,
				git_icons = true,
			},
			quickfix_stack = {
				prompt = 'Quickfix Stack> ',
				marker = '>', -- current list marker
			},
			lsp = {
				prompt_postfix = '❯ ', -- will be appended to the LSP label
				-- to override use 'prompt' instead
				prompt = build_prompt(),
				cwd_only = false, -- LSP/diagnostics for cwd only?
				async_or_timeout = 5000, -- timeout(ms) or 'true' for async calls
				file_icons = true,
				git_icons = false,
				-- The equivalent of using `includeDeclaration` in lsp buf calls, e.g:
				-- :lua vim.lsp.buf.references({includeDeclaration = false})
				includeDeclaration = false, -- include current declaration in LSP context
				-- settings for 'lsp_{document|workspace|lsp_live_workspace}_symbols'
				symbols = {
					prompt = build_prompt(),
					async_or_timeout = true, -- symbols are async by default
					symbol_style = 1, -- style for document/workspace symbols
					-- false: disable,    1: icon+kind
					--     2: icon only,  3: kind only
					symbol_hl = function(s)
						return '@' .. s:lower()
					end,
					-- additional symbol formatting, works with or without style
					symbol_fmt = function(s, opts)
						return '[' .. s .. ']'
					end,
					-- prefix child symbols. set to any string or `false` to disable
					child_prefix = true,
					fzf_opts = {
						['--tiebreak'] = 'begin',
					},
				},
				code_actions = {
					prompt = build_prompt(),
					async_or_timeout = 5000,
					-- when git-delta is installed use "codeaction_native" for beautiful diffs
					-- try it out with `:FzfLua lsp_code_actions previewer=codeaction_native`
					-- scroll up to `previewers.codeaction{_native}` for more previewer options
					previewer = false,
				},
				finder = {
					file_icons = true,
					color_icons = true,
					git_icons = false,
					async = true, -- async by default
					silent = true, -- suppress "not found"
					separator = '| ', -- separator after provider prefix, `false` to disable
					includeDeclaration = false, -- include current declaration in LSP context
					-- by default display all LSP locations
					-- to customize, duplicate table and delete unwanted providers
					providers = {
						{ 'references', prefix = require('fzf-lua').utils.ansi_codes.blue 'ref ' },
						{ 'definitions', prefix = require('fzf-lua').utils.ansi_codes.green 'def ' },
						{ 'declarations', prefix = require('fzf-lua').utils.ansi_codes.magenta 'decl' },
						{ 'typedefs', prefix = require('fzf-lua').utils.ansi_codes.red 'tdef' },
						{ 'implementations', prefix = require('fzf-lua').utils.ansi_codes.green 'impl' },
						{ 'incoming_calls', prefix = require('fzf-lua').utils.ansi_codes.cyan 'in  ' },
						{ 'outgoing_calls', prefix = require('fzf-lua').utils.ansi_codes.yellow 'out ' },
					},
				},
			},
			diagnostics = {
				cwd_only = false,
				file_icons = true,
				git_icons = false,
				diag_icons = true,
				diag_source = true, -- display diag source (e.g. [pycodestyle])
				icon_padding = '', -- add padding for wide diagnostics signs
				multiline = true, -- concatenate multi-line diags into a single line
				-- set to `false` to display the first line only
				-- by default icons and highlights are extracted from 'DiagnosticSignXXX'
				-- and highlighted by a highlight group of the same name (which is usually
				-- set by your colorscheme, for more info see:
				--   :help DiagnosticSignHint'
				--   :help hl-DiagnosticSignHint'
				-- only uncomment below if you wish to override the signs/highlights
				-- define only text, texthl or both (':help sign_define()' for more info)
				-- signs = {
				--   ["Error"] = { text = "", texthl = "DiagnosticError" },
				--   ["Warn"]  = { text = "", texthl = "DiagnosticWarn" },
				--   ["Info"]  = { text = "", texthl = "DiagnosticInfo" },
				--   ["Hint"]  = { text = "󰌵", texthl = "DiagnosticHint" },
				-- },
				-- limit to specific severity, use either a string or num:
				--   1 or "hint"
				--   2 or "information"
				--   3 or "warning"
				--   4 or "error"
				-- severity_only:   keep any matching exact severity
				-- severity_limit:  keep any equal or more severe (lower)
				-- severity_bound:  keep any equal or less severe (higher)
			},
			complete_path = {
				cmd = nil, -- default: auto detect fd|rg|find
				complete = { ['default'] = actions.complete },
			},
			complete_file = {
				cmd = nil, -- default: auto detect rg|fd|find
				file_icons = true,
				color_icons = true,
				git_icons = false,
				-- actions inherit from 'actions.files' and merge
				actions = { ['default'] = actions.complete },
				-- previewer hidden by default

				winopts = {
					preview = {
						hidden = 'hidden',
						delay = 10,
					},
				},
			},
			-- uncomment to use fzf native previewers
			-- (instead of using a neovim floating window)
			-- manpages = { previewer = "man_native" },
			-- helptags = { previewer = "help_native" },
			--
			-- optional override of file extension icon colors
			-- available colors (terminal):
			--    clear, bold, black, red, green, yellow
			--    blue, magenta, cyan, grey, dark_grey, white
			file_icon_colors = {
				['sh'] = 'green',
			},
			-- padding can help kitty term users with
			-- double-width icon rendering
			file_icon_padding = '',
			-- uncomment if your terminal/font does not support unicode character
			-- 'EN SPACE' (U+2002), the below sets it to 'NBSP' (U+00A0) instead
			-- nbsp = '\xc2\xa0',
		}
	end,
}
