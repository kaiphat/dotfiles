local u = require 'utils'

local cmd = function(name, fn, opts)
	opts = opts or {}
	vim.api.nvim_create_user_command(name, fn, opts)
end

cmd('Squeeze', function()
	-- make from several \n only one
	vim.cmd 'silent! %s/\\v(\\n\\n)\\n+/\\1/e'
end)

cmd('DeleteEmptyLines', function()
	-- remove all empty lines
	vim.cmd 'silent! %s/\\v(\\n)\\n+/\\1/e'
end)

cmd('DeleteSpaces', function()
	-- make from many \s in one line only one
	vim.cmd 'silent! s/\\S\\@<=\\s\\+/ /g'
	vim.cmd 'silent! nohl'
end)

cmd('CopyFilePath', function()
	vim.cmd 'silent! let @+=expand("%:p")'
	print 'File path was yanked'
end)

cmd('CreateSubTitle', function(opts)
	local char = opts.fargs[1]

	local MAX_LENGTH = 60
	local SPACE_LENGTH = 5
	local DEFAULT_CHAR = '┈'

	char = (char == '' or char == nil) and '#' or char

	local row = u.get_row_col()

	local line = vim.trim(vim.api.nvim_get_current_line():gsub(char, ''):gsub(DEFAULT_CHAR, ''))
	local free_space = MAX_LENGTH - #line - SPACE_LENGTH * 2
	local left_line_length = math.floor(free_space / 2)
	local left = DEFAULT_CHAR:rep(left_line_length)
	local right = DEFAULT_CHAR:rep(free_space - left_line_length)

	local space = (' '):rep(SPACE_LENGTH)
	local title = char .. ' ' .. left .. space .. line .. space .. right

	vim.api.nvim_buf_set_lines(0, row - 1, row, true, { title })
end, { nargs = '*' })

cmd('CreateTitle', function(opts)
	local char = opts.fargs[1]

	local MAX_LENGTH = 60
	local SPACE_LENGTH = 3
	local DEFAULT_CHAR = '┈'

	char = (char == '' or char == nil) and '#' or char

	local row = u.get_row_col()

	local line = vim.trim(vim.api.nvim_get_current_line():gsub(char, ''):gsub(DEFAULT_CHAR, ''))
	local left_line_length = math.floor((MAX_LENGTH - #line - SPACE_LENGTH * 2) / 2)
	local left = DEFAULT_CHAR:rep(left_line_length)
	local right = DEFAULT_CHAR:rep(MAX_LENGTH - #line - SPACE_LENGTH * 2 - left_line_length)

	local next_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
	local space = (' '):rep(SPACE_LENGTH)
	local title = char .. ' ' .. left .. space .. line .. space .. right

	local border = char .. ' ' .. DEFAULT_CHAR:rep(MAX_LENGTH)

	vim.api.nvim_buf_set_lines(0, row - 1, row, true, { border, title, border })

	if vim.trim(next_line) ~= '' then
		vim.api.nvim_buf_set_lines(0, row + 2, row + 2, true, { '' })
	end
end, { nargs = '*' })

cmd('FileType', function()
	print(vim.bo.filetype)
end)

cmd('RunTest', function()
	local relative_path = u.get_relative_path()
	local tmux_socket = vim.fn.split(vim.env.TMUX, ',')[1]
	local cmd_string = string.format(
		[[
            tmux -S %s select-pane -L \;\
            send-keys C-c \;\
            run-shell "tmux respawn-pane -k 'SPEC=%s make test-watch; exec fish'"
        ]],
		tmux_socket,
		relative_path
	)

	vim.fn.system(cmd_string)
end)

cmd('CopyGitHubFileLink', function()
	local branch = vim.trim(vim.fn.system 'git rev-parse --abbrev-ref HEAD')
	local remote_root = vim.trim(vim.fn.system 'util:get_git_remote_root')
	local relative_path = u.get_relative_path()
	local row_index = vim.api.nvim_win_get_cursor(0)[1]
	local url = string.format('https://github.com/%s/blob/%s/%s#L%d', remote_root, branch, relative_path, row_index)
	vim.fn.setreg('+', url)
end)
