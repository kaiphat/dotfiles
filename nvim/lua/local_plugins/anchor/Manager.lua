local M = {}

M.__index = M

local function build_path(git_branch, cwd)
	local file_name = string.format('kaiphat_anchor:%s:%s.json', cwd, git_branch or 'nobranch')
	local escaped = string.gsub(file_name, '[\\/]', '_')
	return string.format('%s/%s', vim.fn.stdpath 'data', escaped)
end

function M:new(opts)
	return setmetatable({
		path = require('plenary.path'):new(build_path(opts.git_branch, opts.cwd)),
		anchors = nil,
	}, self)
end

function M:setup()
	local anchors = {}

	if self.path:exists() then
		anchors = vim.json.decode(self.path:read())
	end

	self.anchors = anchors
end

function M:save_json()
	if self.anchors and #self.anchors > 0 then
		self.path:write(vim.json.encode(self.anchors), 'w')
	end
end

function M:remove_anchor(index)
	self.anchors[index] = nil
end

function M:load_buffer(index)
	local anchor = self.anchors[index]

	if anchor == nil then
		vim.notify 'Anchor not found'
		return
	end

	local bufnr = vim.fn.bufnr(anchor.path)
	local cur_buf = vim.api.nvim_get_current_buf()

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

	if bufnr == cur_buf then
		vim.api.nvim_win_set_cursor(0, {
			anchor.row or 1,
			anchor.col or 0,
		})
	end
end

function M:add_anchor(new_index)
	local row, col = __.utils.get_row_col()
	local current_path = __.utils.get_full_path()

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

function M:get_buf_anchor_index(file)
	if not self.anchors then
		return
	end

	for index, anchor in pairs(self.anchors) do
		if anchor.path == file then
			return index
		end
	end
end

return M
