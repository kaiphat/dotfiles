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
		path = Path:new(build_path(opts.git_branch, opts.cwd)),
		anchors = nil,
	}, self)
end

function Manager:setup()
	if not self.path:exists() then
		self.path:write(vim.json.encode {}, 'w')
	end

	local out_data = self.path:read()

	self.anchors = vim.json.decode(out_data)
end

function Manager:save_json()
	self.path:write(vim.json.encode(self.anchors or {}), 'w')
end

function Manager:remove_anchor(index)
	self.anchors[index] = nil
end

function Manager:load_buffer(index)
	local anchor = self.anchors[index]

	if anchor == nil then
		vim.notify 'Anchor not found'
		return
	end

	local bufnr = vim.fn.bufnr(anchor.path)

	if bufnr == -1 then
		bufnr = vim.fn.bufnr(anchor.path, true)
	end

	if not vim.api.nvim_buf_is_loaded(bufnr) then
		vim.fn.bufload(bufnr)
		vim.api.nvim_set_option_value('buflisted', true, {
			buf = bufnr,
		})
	end

	vim.api.nvim_set_current_buf(bufnr)
end

function Manager:move_cursor_to_anchor()
	local file = kaiphat.utils.get_full_path()
	local index = self:get_buf_anchor_index(file)

	if not index then
		return
	end

	local anchor = self.anchors[index]

	vim.cmd.normal 'm\''
	vim.api.nvim_win_set_cursor(0, {
		anchor.row or 1,
		anchor.col or 0,
	})
end

function Manager:add_anchor(new_index)
	local row, col = kaiphat.utils.get_row_col()
	local current_path = kaiphat.utils.get_full_path()

	for index, anchor in pairs(self.anchors) do
		if anchor.path == current_path and index ~= new_index then
			self:remove_anchor(index)
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
	if not self.anchors then
		return
	end

	for index, anchor in pairs(self.anchors) do
		if anchor.path == file then
			return index
		end
	end
end

return Manager
