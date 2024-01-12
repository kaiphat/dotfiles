local utils = require 'local_plugins.marks.utils'

local Path_builder = {}

Path_builder.__index = Path_builder

function Path_builder:new()
	return setmetatable({
		data_path = vim.fn.stdpath 'data',
	}, self)
end

function Path_builder:build_file_name()
	local prefix = 'MARKS'
	local postfix = '.json'

    local root_dir = utils.get_root_dir()
	local git_branch = utils.get_git_branch()

	return prefix .. ':' .. (git_branch or root_dir) .. postfix
end

function Path_builder:build()
	local file_name = self:build_file_name()
	file_name = string.gsub(file_name, '/', '_')
	return string.format('%s/%s', self.data_path, file_name)
end

return Path_builder
