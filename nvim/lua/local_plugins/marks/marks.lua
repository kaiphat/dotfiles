local saver = require 'local_plugins.marks.saver'
local path = require 'local_plugins.marks.path'

local marks

local function on_start() marks = saver.read_from_file(path.build()) end

local function on_exit()
	vim.api.nvim_create_autocmd({ 'BufLeave', 'VimLeavePre' }, {
		group = vim.api.nvim_create_augroup('marks_plugin_group', {}),
		pattern = '*',
		callback = function() saver.save_to_file(path.build(), marks or {}) end,
	})
end

local function load_buffer(mark)
	if mark == nil then
		print 'Mark not found'
		return
	end

	local bufnr = vim.fn.bufnr(mark.path)

	if bufnr == -1 then bufnr = vim.fn.bufnr(mark.path, true) end

	if not vim.api.nvim_buf_is_loaded(bufnr) then
		vim.fn.bufload(bufnr)
		vim.api.nvim_set_option_value('buflisted', true, {
			buf = bufnr,
		})
	end

	vim.api.nvim_set_current_buf(bufnr)

	vim.api.nvim_win_set_cursor(0, {
		mark.row or 1,
		mark.col or 0,
	})
end

local function clear_mark(index) marks[index] = nil end

local function add_mark(new_index)
	local row, col = get_row_col()
	local current_path = path.get_current_path()

	for index, mark in pairs(marks) do
		if mark.path == current_path and index ~= new_index then
			clear_mark(index)
			break
		end
	end

	marks[new_index] = {
		row = row,
		col = col,
		path = current_path,
	}
end

local function add_keymaps()
	local function map(keys, cmd) vim.keymap.set('n', keys, cmd, { noremap = true, silent = true }) end

	local indexes = '1234qwerasdf'

	for i = 1, #indexes do
		local index = indexes:sub(i, i)
		map('m' .. index, function() add_mark(index) end)

		map('\'' .. index, function()
			local mark = marks[index]
			load_buffer(mark)
		end)
	end

	-- clear
	map('mc', function()
		marks = {}
		print 'Cleared marks'
	end)

	-- cycle
	map('\'n', function()
		local current_path = path.get_current_path()
		local current_path_was_found = false

		for _, mark in pairs(marks) do
			if current_path_was_found then
				load_buffer(mark)
				return
			end
			print(mark.path, current_path)
			if mark.path == current_path then
				current_path_was_found = true
				print(1)
			end
		end

		for _, mark in pairs(marks) do
			load_buffer(mark)
			return
		end
	end)

	-- show
	map('\'s', function()
		local message = ''
		for index, mark in pairs(marks) do
			message = message .. index .. ' -> ' .. mark.path .. ' '
		end
		if message == '' then message = 'No marks' end
		print(message)
	end)
end

local function setup()
	on_start()

	add_keymaps()

	on_exit()
end

return {
	setup = setup,
}
