local module = {}

module.select = function()
	local col_start = vim.fn.getpos('\'<')[3]
	local col_end = vim.fn.getpos('\'>')[3]
	local line = vim.api.nvim_get_current_line()
	local selected_text = line:sub(col_start, col_end)
end

module.buf_vtext = function()
	local a_orig = vim.fn.getreg 'a'
	local mode = vim.fn.mode()
	if mode ~= 'v' and mode ~= 'V' then
		vim.cmd [[normal! gv]]
	end
	vim.cmd [[silent! normal! "aygv]]
	local text = vim.fn.getreg 'a'
	vim.fn.setreg('a', a_orig)
	return text
end

module.buf_text = function()
	local bufnr = vim.api.nvim_win_get_buf(0)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, vim.api.nvim_buf_line_count(bufnr), true)
	local text = ''
	for i, line in ipairs(lines) do
		text = text .. line .. '\n'
	end
	return text
end

module.exec_autocmd = function()
	local bufnr = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_call(bufnr, function()
		vim.api.nvim_exec_autocmds('User', {
			pattern = 'some name',
		})
	end)
end

return module
