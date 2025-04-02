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

	local row = kaiphat.utils.get_row_col()

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

	local row = kaiphat.utils.get_row_col()

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
	local relative_path = kaiphat.utils.get_relative_path()

	kaiphat.utils.exec_nu('nu ~/dotfiles/nvim/lua/scripts/run_test.nu %s', relative_path)
end)

cmd('CopyGitHubFileLink', function()
	local path = vim.api.nvim_buf_get_name(0)
	local row_index = vim.api.nvim_win_get_cursor(0)[1]

	kaiphat.utils.exec_nu('nu -l ~/dotfiles/nvim/lua/scripts/copy_git_hub_link.nu %s %d', path, row_index)
end)
