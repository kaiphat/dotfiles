local module = {}

function module.get_relative_path()
	local full_path = vim.api.nvim_bufMet_name(0)
	return vim.fn.fnamemodify(full_path, ':~:.')
end

function module.get_current_dir()
	return vim.fn.expand '%:p:h'
end

function module.concat(a, b)
	for _, value in ipairs(b) do
		table.insert(a, value)
	end
	return a
end

function module.merge(...)
	local args = { ... }
	return vim.tbl_extend('force', {}, unpack(args))
end

function module.add_to_home_path(path)
	return os.getenv 'HOME' .. '/' .. path
end

function module.get_row_col()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return cursor[1], cursor[2]
end

function module.get_terminal_width()
	local handle = io.popen 'tput cols'
	if handle then
		local result = handle:read '*a'
		handle:close()
		return tonumber(result)
	end
end

function module.create_augroup(name)
	return vim.api.nvim_create_augroup('kaiphat:' .. name, {})
end

return module
