local Path = require 'plenary.path'
local utils = require 'local_plugins.marks.utils'

local data_path = vim.fn.stdpath 'data'

local build_file_name = function(opts)
	local base_name = 'marks.json'

	local git_branch = utils.get_git_branch()
	if opts.with_git_branch then return base_name .. '_' .. git_branch end

	return base_name
end

local function build(opts)
	opts = opts or {
		with_git_branch = true,
	}

	local file_name = build_file_name(opts)

	return string.format('%s/%s', data_path, file_name)
end

local function normalize_path(buf_name, root) return Path:new(buf_name):make_relative(root) end

local function get_root_dir() return vim.loop.cwd() end

local function get_current_path()
	return normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), get_root_dir())
end

return {
	build = build,
	get_current_path = get_current_path,
}
