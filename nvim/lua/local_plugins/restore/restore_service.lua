local Path = require 'plenary.path'

local RestoreService = {}

RestoreService.__index = RestoreService

function RestoreService:new()
	return setmetatable({
		group = vim.api.nvim_create_augroup('restore_service', {}),
		fs = Path:new(vim.fn.stdpath 'data' .. '/test1.json'),
	}, self)
end

function RestoreService:get_visible_buffers()
	local buffers = vim.fn.getbufinfo { buflisted = 1 }
	local result = {}
	for _, buf in ipairs(buffers) do
		if buf.hidden == 0 and buf.name and buf.name ~= '' then
			table.insert(result, buf)
		end
	end
	return result
end

function RestoreService:open_buffers(buffers)
	for _, buf in ipairs(buffers) do
		vim.cmd 'vs'

		local bufnr = vim.fn.bufnr(buf.name)

		if bufnr == -1 then
			bufnr = vim.fn.bufnr(buf.name, true)
		end

		if not vim.api.nvim_buf_is_loaded(bufnr) then
			vim.fn.bufload(bufnr)
			vim.api.nvim_set_option_value('buflisted', true, {
				buf = bufnr,
			})
		end

		vim.api.nvim_set_current_buf(bufnr)
	end
end

function RestoreService:restore()
	local data = self:read_data()

	if not data then
		return
	end

	self:open_buffers(data.buffers)
end

function RestoreService:prepare_to_save(buffers)
	local result = {}
	for _, buf in ipairs(buffers) do
		table.insert(result, { name = buf.name })
	end
	return result
end

function RestoreService:read_data()
	local exists = self.fs:exists()

	if not exists then
		-- i'm lazy
		return
	end

	return vim.json.decode(self.fs:read())
end

function RestoreService:save_data()
	local buffers = self:get_visible_buffers()
	local buffers_to_save = self:prepare_to_save(buffers)

	self.fs:write(vim.json.encode { buffers = buffers_to_save }, 'w')
end

function RestoreService:setup()
	vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
		group = self.group,
		pattern = '*',
		callback = function()
			self:save_data()
		end,
	})
end

return RestoreService:new()
