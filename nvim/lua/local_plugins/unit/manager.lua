local ts = require 'nvim-treesitter.ts_utils'

local Manager = {}

Manager.__index = Manager

function Manager:new()
	return setmetatable({}, self)
end

function Manager:get_row_col()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return {
		row = cursor[1],
		col = cursor[2],
	}
end

function Manager:get_line_text(bufnr, line)
	return vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
end

function Manager:get_node(coords)
	local row = coords.row
	local col = coords.col

	local root = ts.get_root_for_position(row - 1, col)

	if not root then
		return
	end

	return root:named_descendant_for_range(row - 1, col, row - 1, col)
end

function Manager:get_main_node(position)
	local node = self:get_node(position)

	if node == nil then
		return
	end

	local parent = node:parent()

	local root = ts.get_root_for_node(node)

	local start_row = node:start()

	while parent and parent ~= root and parent:start() == start_row do
		node = parent
		parent = node:parent()
	end

	return node
end

function Manager:move_row_while_empty(bufnr, row, delta)
	if self:get_line_text(bufnr, row) == '' then
		local parent = row + delta
		local line_parent = self:get_line_text(bufnr, parent)
		while parent >= 0 and line_parent == '' do
			row = parent
			parent = row + delta
			line_parent = self:get_line_text(bufnr, parent)
		end
	end

	return row
end

function Manager:move_col_while_empty(bufnr, row)
	local text = self:get_line_text(bufnr, row)
	local found = string.find(text, '[^%s]')
	return found and found - 1 or 0
end

function Manager:get_selection_range(outer)
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = self:get_row_col()
	local init_row = cursor.row

	if outer and self:get_line_text(bufnr, cursor.row) == '' then
		cursor.row = self:move_row_while_empty(bufnr, cursor.row, 1) + 1
		cursor.col = 0
	end

	if outer then
		cursor.col = self:move_col_while_empty(bufnr, cursor.row)
	end

	local node = self:get_main_node(cursor)

	if node == nil then
		return
	end

	local start_row, start_col, end_row, end_col = node:range()

	if outer then
		if init_row < cursor.row then
			start_row = self:move_row_while_empty(bufnr, start_row, -1) - 1
		else
			local text = self:get_line_text(bufnr, end_row + 2)
			if text == '' then
				end_row = self:move_row_while_empty(bufnr, end_row + 2, 1) - 1
				start_col = 0
			end
		end
	end

	return {
		node = node,
		start_row = start_row,
		start_col = start_col,
		end_row = end_row,
		end_col = end_col,
	}
end

function Manager:select_range(bufnr, start_row, start_col, end_row, end_col)
	vim.fn.setpos('.', { bufnr, start_row + 1, start_col + 1, 0 })
	vim.cmd 'normal! V'
	vim.fn.setpos('.', { bufnr, end_row + 1, end_col, 0 })
end

function Manager:select(outer)
	local bufnr = vim.api.nvim_get_current_buf()
	local range = self:get_selection_range(outer)

	if not range or range.start_row == nil then
		return
	end

	self:select_range(bufnr, range.start_row, range.start_col, range.end_row, range.end_col)
end

function Manager:get_nearest_char_position_up(coords)
	local row = coords.row
	local text, col

	while true do
		if row == 0 then
			return {
				row = 1,
				col = 1,
			}
		end

		text = self:get_line_text(0, row)
		col = string.find(text, '[a-zA-Z]')

		if col then
			break
		end

		row = row - 1
	end

	return {
		row = row,
		col = col,
	}
end

function Manager:jump_to_parent_unit(is_fallback)
	local cursor = self:get_row_col()

	if cursor.row == 1 then -- first line
		return
	end

	local char_coords = self:get_nearest_char_position_up(cursor)

	local node = self:get_node(char_coords)

	if not node then
		return
	end

	local parent_node = node:parent()

	if not parent_node then
		return
	end

	if not is_fallback then
		vim.cmd 'normal! m\'' -- add current cursor position to the jump list
	end

	local parent_row, parent_col = parent_node:range()

	char_coords = self:get_nearest_char_position_up { row = parent_row }

	vim.api.nvim_win_set_cursor(0, { math.max(1, parent_row), math.max(1, parent_col) - 1 })

	if parent_row ~= char_coords.row or parent_col ~= char_coords.col then
		self:jump_to_parent_unit(true)
	end
end

function Manager:jump_to_neighbor_unit(opts) end

function Manager:setup() end

return Manager
