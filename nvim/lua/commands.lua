vim.api.nvim_create_user_command('Squeeze', function()
	vim.cmd 'silent! %s/\\v(\\n\\n)\\n+/\\1/e'
end, {})

vim.api.nvim_create_user_command('DeleteEmptyLines', function()
	vim.cmd 'silent! %s/\\v(\\n)\\n+/\\1/e'
end, {})

vim.api.nvim_create_user_command('DeleteSpaces', function()
	vim.cmd 'silent! s/S@<=s+/ /g'
	vim.cmd 'silent! nohl'
end, {})

vim.api.nvim_create_user_command('CopyFilePath', function()
	vim.cmd 'silent! let @+=expand("%:p")'
	print 'File path was yanked'
end, {})

vim.api.nvim_create_user_command('CreateSubTitle', function(opts)
	local char = opts.fargs[1]

	local MAX_LENGTH = 60
	local SPACE_LENGTH = 5
	local DEFAULT_CHAR = '┈'

	char = (char == '' or char == nil) and '#' or char

	local row = get_row_col()

	local line = vim.trim(vim.api.nvim_get_current_line():gsub(char, ''):gsub(DEFAULT_CHAR, ''))
	local free_space = MAX_LENGTH - #line - SPACE_LENGTH * 2
	local left_line_length = math.floor(free_space / 2)
	local left = DEFAULT_CHAR:rep(left_line_length)
	local right = DEFAULT_CHAR:rep(free_space - left_line_length)

	local space = (' '):rep(SPACE_LENGTH)
	local title = char .. ' ' .. left .. space .. line .. space .. right

	vim.api.nvim_buf_set_lines(0, row - 1, row, true, { title })
end, { nargs = '*' })

vim.api.nvim_create_user_command('CreateTitle', function(opts)
	local char = opts.fargs[1]

	local MAX_LENGTH = 60
	local SPACE_LENGTH = 3
	local DEFAULT_CHAR = '┈'

	char = (char == '' or char == nil) and '#' or char

	local row = get_row_col()

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

vim.api.nvim_create_user_command('FileType', function()
	print(vim.bo.filetype)
end, {})

vim.api.nvim_create_user_command('RunTest', function()
	local path = vim.api.nvim_buf_get_name(0)
	local relative_path = vim.fn.fnamemodify(path, ':~:.')
	local tmux_socket = vim.fn.split(vim.env.TMUX, ',')[1]

	vim.fn.system(string.format(
		[[
            tmux -S %s select-pane -L \; respawn-pane -k 'SPEC=%s make test-watch'
        ]],
		tmux_socket,
		relative_path
	))
end, {})
