local utils = require 'local_plugins.marks.utils'

local Path_builder = {}

Path_builder.__index = Path_builder

function Path_builder:new()
	return setmetatable({
		data_path = vim.fn.stdpath 'data',
	}, self)
end

function Path_builder:build_file_name()
	local base_name = 'marks'
	local postfix = '.json'

	local git_branch = utils.get_git_branch()

	return base_name .. '_' .. git_branch .. postfix
end

function Path_builder:build()
	local file_name = self:build_file_name()

	return string.format('%s/%s', self.data_path, file_name)
end

return Path_builder
