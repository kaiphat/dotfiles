local M = {}

function M.get_full_path(buf)
	return vim.api.nvim_buf_get_name(buf or 0)
end

function M.get_relative_path()
	local full_path = vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(full_path, ':~:.')
end

function M.get_current_dir()
	return vim.fn.expand '%:p:h'
end

function M.merge(...)
	local args = { ... }
	return vim.tbl_extend('force', {}, unpack(args))
end

function M.concat(...)
	local result = {}
	local args = { ... }
	for _, i in ipairs(args) do
		for _, j in ipairs(i) do
			table.insert(result, j)
		end
	end
	return result
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

function M.exec_nu(...)
	return vim.fn.system(string.format('nu -c "%s"', string.format(...)))
end

function M.exec(cmd)
	return vim.trim(vim.fn.system(cmd))
end

function M.get_git_root()
	return M.exec 'git rev-parse --show-toplevel'
end

function M.get_git_branch()
	local git_branch = vim.fn.systemlist('git branch --show-current')[1]
	if string.find(git_branch, 'fatal') then
		return nil
	end
	return git_branch
end

function M.get_root_dir()
	return vim.loop.cwd()
end

kaiphat.utils = M
