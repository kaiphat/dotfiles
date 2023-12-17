vim.cmd [[command! Squeeze %s/\v(\n\n)\n+/\1/e]]
vim.cmd [[command! DeleteEmptyLines %s/\v(\n)\n+/\1/e]]
vim.cmd [[command! DeleteSpaces lua require('commands').delete_spacec()]]
vim.cmd [[command! CopyFilePath lua require('commands').copy_file_path()]]
vim.cmd [[command! SnakeCase lua require('commands').snake()]]
vim.cmd [[command! CamelCase lua require('commands').camel()]]
vim.cmd [[command! -nargs=* CreateSubTitle lua require('commands').create_sub_title('<args>')]]
vim.cmd [[command! -nargs=* CreateTitle lua require('commands').create_title('<args>')]]

return {
	copy_file_path = function()
		vim.cmd 'silent! let @+=expand("%:p")'
		print 'File path was yanked'
	end,

	delete_spacec = function()
		vim.cmd [[silent! s/\S\@<=\s\+/ /g]]
		vim.cmd [[silent! nohl]]
	end,

	split_string = function(str, delimiter)
		local result = {}
		for match in (str .. delimiter):gmatch('(.-)' .. delimiter) do
			table.insert(result, match)
		end
		return result
	end,

	snake = function(s)
		return s:gsub('%f[^%l]%u', '_%1')
			:gsub('%f[^%a]%d', '_%1')
			:gsub('%f[^%d]%a', '_%1')
			:gsub('(%u)(%u%l)', '%1_%2')
			:upper()
	end,

	camel = function(s)
		s = s:lower()
		return string.gsub(s, '_%a+', function(word)
			local first = string.sub(word, 2, 2)
			local rest = string.sub(word, 3)
			return string.upper(first) .. rest
		end)
	end,

	create_sub_title = function(char)
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
	end,

	create_title = function(char)
		local MAX_LENGTH = 60
		local SPACE_LENGTH = 3
		local DEFAULT_CHAR = '┈'

		char = char or '#'

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

		if vim.trim(next_line) ~= '' then vim.api.nvim_buf_set_lines(0, row + 2, row + 2, true, { '' }) end
	end,
}
