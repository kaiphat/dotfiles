local Fs = require 'local_plugins.marks.fs'
local Path_builder = require 'local_plugins.marks.path_builder'
local utils = require 'local_plugins.marks.utils'

local function map(keys, cmd)
	vim.keymap.set('n', keys, cmd, { noremap = true, silent = true })
end

local Manager = {}

Manager.__index = Manager

function Manager:new()
	return setmetatable({
		marks = {},
		active_mark_index = nil,
		fs = Fs:new(Path_builder:new():build()),
		group = vim.api.nvim_create_augroup('marks_plugin_group', {}),
	}, self)
end

function Manager:on_start()
	self.marks = self.fs:read()
end

function Manager:on_exit() end

function Manager:load_buffer(mark)
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

	vim.api.nvim_win_set_cursor(0, {
		mark.row or 1,
		mark.col or 0,
	})
end

function Manager:clear_all_marks()
	self.marks = {}
	self.active_mark_index = nil
end

function Manager:clear_mark(index)
	self.marks[index] = nil
end

function Manager:add_mark(new_index)
	local row, col = utils.get_row_col()
	local current_path = utils.get_current_path()

	for index, mark in pairs(self.marks) do
		if mark.path == current_path and index ~= new_index then
			self:clear_mark(index)
			break
		end
	end

	self.marks[new_index] = {
		row = row,
		col = col,
		path = current_path,
	}
	self.active_mark_index = new_index
end

function Manager:add_keymaps()
    local all_leters = 'abcdefghijklmnopqrstuvwxyz'
	local indexes = '1234567890,.;\'[]'..all_leters

	for i = 1, #indexes do
		local index = indexes:sub(i, i)
		map('m' .. index, function()
			self:add_mark(index)
			vim.notify('Marked as ' .. index)
		end)

		map([[']].. index, function()
			local mark = self.marks[index]
			self:load_buffer(mark)
		end)
	end

	-- clear
	map('<leader>mC', function()
		self:clear_all_marks()
		vim.notify 'Cleared marks'
	end)

	-- loop
	map('<leader>ml', function()
		self:next_mark()
	end)

	-- open all
	-- TODO: don't repeat already opened
	map('<leader>mo', function()
		local is_first = true

		for _, mark in pairs(self.marks) do
			if is_first then
				self:load_buffer(mark)
				is_first = false
			else
				vim.cmd 'vs'
				self:load_buffer(mark)
			end
		end
	end)

	-- show marks
	map('<leader>ms', function()
		local message = ''

		for index, mark in pairs(self.marks) do
			if message ~= '' then
				message = message .. '\n'
			end
			message = message .. index:upper() .. ' ' .. mark.path .. ' '
		end

		if message == '' then
			message = 'No marks'
        else
            message = 'Marks:\n' .. message
        end

		vim.notify(message)
	end)
end

function Manager:next_mark(is_fallback)
	if is_fallback then
		for _, mark in pairs(self.marks) do
			self:load_buffer(mark)
			return
		end
	else
		if self.active_mark_index == nil then
			self:next_mark(true)
		end

		local current_was_found = false

		for index, mark in pairs(self.marks) do
			if current_was_found then
				self:load_buffer(mark)
				return
			end
			if index == self.active_mark_index then
				current_was_found = true
			end
		end

		self:next_mark(true)
	end
end

function Manager:get_active_buffer_mark()
	local path = utils.get_current_path()

	for _, mark in pairs(self.marks) do
		if mark.path == path then
			return mark
		end
	end
end

function Manager:setup()
	self:on_start()

	vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
		group = self.group,
		pattern = '*',
		callback = function()
			self.fs:write(self.marks)
		end,
	})

	vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
		group = self.group,
		pattern = '*',
		callback = function(event)
			local path = utils.get_buffer_path(event.buf)

			if not path then
				return
			end

			for index, mark in pairs(self.marks) do
				if mark.path == path then
					self.active_mark_index = index
					return
				end
			end
			self.active_mark_index = nil
		end,
	})

	self:add_keymaps()
end

return Manager:new()
