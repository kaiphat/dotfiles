local ts = require 'nvim-treesitter.ts_utils'

local function get_row_col()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return {
		row = cursor[1],
		col = cursor[2],
	}
end

local function get_line_text(bufnr, line)
	return vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
end

local function get_node(coords)
	local row = coords.row
	local col = coords.col

	local root = ts.get_root_for_position(row - 1, col)

	if not root then
		return
	end

	return root:named_descendant_for_range(row - 1, col, row - 1, col)
end

local function get_main_node(position)
	local node = get_node(position)

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

local function move_row_while_empty(bufnr, row, delta)
	if get_line_text(bufnr, row) == '' then
		local parent = row + delta
		local line_parent = get_line_text(bufnr, parent)
		while parent >= 0 and line_parent == '' do
			row = parent
			parent = row + delta
			line_parent = get_line_text(bufnr, parent)
		end
	end

	return row
end

local function move_col_while_empty(bufnr, row)
	local text = get_line_text(bufnr, row)
	local found = string.find(text, '[^%s]')
	return found and found - 1 or 0
end

local function get_selection_range(outer)
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = get_row_col()
	local init_row = cursor.row

	if outer and get_line_text(bufnr, cursor.row) == '' then
		cursor.row = move_row_while_empty(bufnr, cursor.row, 1) + 1
		cursor.col = 0
	end

	if outer then
		cursor.col = move_col_while_empty(bufnr, cursor.row)
	end

	local node = get_main_node(cursor)

	if node == nil then
		return
	end

	local start_row, start_col, end_row, end_col = node:range()

	if outer then
		if init_row < cursor.row then
			start_row = move_row_while_empty(bufnr, start_row, -1) - 1
		else
			local text = get_line_text(bufnr, end_row + 2)
			if text == '' then
				end_row = move_row_while_empty(bufnr, end_row + 2, 1) - 1
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

local function select_range(bufnr, start_row, start_col, end_row, end_col)
	vim.fn.setpos('.', { bufnr, start_row + 1, start_col + 1, 0 })
	vim.cmd 'normal! V'
	vim.fn.setpos('.', { bufnr, end_row + 1, end_col, 0 })
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     public     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local _ = {}

function _.select(outer)
	local bufnr = vim.api.nvim_get_current_buf()
	local range = get_selection_range(outer)

	if not range or range.start_row == nil then
		return
	end

	select_range(bufnr, range.start_row, range.start_col, range.end_row, range.end_col)
end

function _.setup() end

return _
