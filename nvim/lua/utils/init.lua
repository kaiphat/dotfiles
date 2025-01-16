local M = {}

function M.get_relative_path()
	local full_path = vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(full_path, ':~:.')
end

function M.get_current_dir()
	return vim.fn.expand '%:p:h'
end

function M.concat(a, b)
	for _, value in ipairs(b) do
		table.insert(a, value)
	end
	return a
end

function M.merge(...)
	local args = { ... }
	return vim.tbl_extend('force', {}, unpack(args))
end

function M.add_to_home_path(path)
	return os.getenv 'HOME' .. '/' .. path
end

function M.get_row_col()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return cursor[1], cursor[2]
end

function M.get_terminal_width()
	local handle = io.popen 'tput cols'
	if handle then
		local result = handle:read '*a'
		handle:close()
		return tonumber(result)
	end
end

function M.create_augroup(name)
	return vim.api.nvim_create_augroup('kaiphat:' .. name, {})
end

kaiphat.utils = M
