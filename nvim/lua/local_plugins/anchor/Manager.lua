local Path = require 'plenary.path'

local Manager = {}

Manager.__index = Manager

local function build_path(git_branch, cwd)
	local file_name = string.format('kaiphat_anchor:%s:%s.json', cwd, git_branch or 'nobranch')
	local escaped = string.gsub(file_name, '[\\/]', '_')
	return string.format('%s/%s', vim.fn.stdpath 'data', escaped)
end

function Manager:new(opts)
	return setmetatable({
		git_branch = opts.git_branch,
		cwd = opts.cwd,
		path = Path:new(build_path(opts.git_branch, opts.cwd)),
		json = nil,
		active_mark_index = nil,
	}, self)
end

function Manager:setup()
	vim.schedule(function()
		if not self.path:exists() then
			self.path:write(vim.json.encode {}, 'w')
		end

		local out_data = self.path:read()

		self.anchors = vim.json.decode(out_data)
	end)
end

function Manager:save_json()
	self.path:write(vim.json.encode(self.anchors or {}), 'w')
end

function Manager:load_buffer(index)
	local mark = self.anchors[index]

	if mark == nil then
		vim.notify 'Mark not found'
		return
	end

	local bufnr = vim.fn.bufnr(mark.path)

	if bufnr == -1 then
		bufnr = vim.fn.bufnr(mark.path, true)
	end

	if not vim.api.nvim_buf_is_loaded(bufnr) then
		vim.fn.bufload(bufnr)
		vim.api.nvim_set_option_value('buflisted', true, {
			buf = bufnr,
		})
	end

	vim.api.nvim_set_current_buf(bufnr)

	-- if self.opts.save_position then
	vim.api.nvim_win_set_cursor(0, {
		mark.row or 1,
		mark.col or 0,
	})
	-- end
end

function Manager:add_mark(new_index)
	local row, col = kaiphat.utils.get_row_col()
	local current_path = kaiphat.utils.get_full_path()

	for index, mark in pairs(self.anchors) do
		if mark.path == current_path and index ~= new_index then
			self.anchors[index] = nil
			break
		end
	end

	self.anchors[new_index] = {
		row = row,
		col = col,
		path = current_path,
	}
end

function Manager:get_buf_anchor_index(file)
	for index, mark in pairs(self.anchors) do
		if mark.path == file then
			return index
		end
	end
end

return Manager
