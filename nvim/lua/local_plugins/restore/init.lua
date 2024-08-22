local state = {}

local function get_visible_buffers()
	local buffers = vim.fn.getbufinfo { buflisted = 1 }
	local result = {}
	for _, buf in ipairs(buffers) do
		if buf.hidden == 0 and buf.name and buf.name ~= '' then
			table.insert(result, buf)
		end
	end
	return result
end

local function open_buffers(buffers)
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

local function prepare_to_save(buffers)
	local result = {}
	for _, buf in ipairs(buffers) do
		table.insert(result, { name = buf.name })
	end
	return result
end

local function read_data()
	local exists = state.fs:exists()

	if not exists then
		-- i'm lazy
		return
	end

	return vim.json.decode(state.fs:read())
end

local function save_data()
	local buffers = get_visible_buffers()
	local buffers_to_save = prepare_to_save(buffers)

	state.fs:write(vim.json.encode { buffers = buffers_to_save }, 'w')
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     public     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local _ = {}

function _.restore()
	local data = read_data()

	if not data then
		return
	end

	open_buffers(data.buffers)
end

function _.setup()
	local path = require 'plenary.path'
	state.fs = path:new(vim.fn.stdpath 'data' .. '/test1.json')

	vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
		group = vim.api.nvim_create_augroup('restore_service', {}),
		pattern = '*',
		callback = function()
			save_data()
		end,
	})
end

return _
