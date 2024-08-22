local Path = require 'plenary.path'

local utils = {}

function utils.get_root_dir()
	return vim.loop.cwd()
end

function utils.normalize_path(buf_name, root)
	return Path:new(buf_name):make_relative(root)
end

function utils.get_git_branch()
	local git_branch = vim.fn.systemlist('git branch --show-current')[1]
	if string.find(git_branch, 'fatal') then
		return nil
	end
	return git_branch
end

function utils.get_buffer_path(bufnr)
	local root_dir = utils.get_root_dir()
	local absolute_path = vim.api.nvim_buf_get_name(bufnr)
	if absolute_path == '' then
		return nil
	end
	return utils.normalize_path(absolute_path, root_dir)
end

function utils.get_current_path()
	return utils.get_buffer_path(vim.api.nvim_get_current_buf())
end

function utils.get_row_col()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return cursor[1], cursor[2]
end

return utils
