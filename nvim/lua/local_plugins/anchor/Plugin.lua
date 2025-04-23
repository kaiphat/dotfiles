local Manager = require 'local_plugins.anchor.Manager'

local function map(keys, cmd)
	vim.keymap.set('n', keys, cmd, { noremap = true, silent = true })
end

local Plugin = {}

Plugin.__index = Plugin

function Plugin:new()
	return setmetatable({
		group = kaiphat.utils.create_augroup 'anchor_plugin_group',
		current_buf_anchor_index = nil,
	}, self)
end

function Plugin:create_manager()
	self.manager = Manager:new {
		git_branch = kaiphat.utils.get_git_branch(),
		cwd = kaiphat.utils.get_root_dir(),
	}
	self.manager:setup()
end

function Plugin:add_keymaps()
	local indexes = 'abcdefghijklmnopqrstuvwxyz123456789'

	for i = 1, #indexes do
		local index = indexes:sub(i, i)
		map('m' .. index, function()
			self.manager:add_mark(index)
			self.current_buf_anchor_index = index
			vim.notify('Marked as ' .. index)
		end)

		map([[']] .. index, function()
			self.manager:load_buffer(index)
		end)
	end

	map('<leader>ms', function()
		local items = {}
		for anchor_index, item in pairs(self.manager.anchors) do
			table.insert(items, {
				idx = anchor_index,
				anchor_index = anchor_index,
				score = 1,
				file = item.path,
				text = anchor_index .. '   ' .. item.path,
			})
		end
		Snacks.picker {
			items = items,
			format = function(item)
				local ret = {}
				ret[#ret + 1] = { item.anchor_index .. '  ', 'SnacksPickerLabel' }
				ret[#ret + 1] = { vim.fn.fnamemodify(item.file, ':~:.'), 'SnacksPickerComment' }
				return ret
			end,
		}
	end)
end

function Plugin:get_anchor_index()
	return self.current_buf_anchor_index
end

function Plugin:setup()
	self:create_manager()
	self:add_keymaps()

	vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
		group = self.group,
		pattern = '*',
		callback = function()
			self.manager:save_json()
		end,
	})

	vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
		group = self.group,
		pattern = '*',
		callback = function(event)
			if event.file == '' then
				return
			end
			self.current_buf_anchor_index = self.manager:get_buf_anchor_index(event.file)
		end,
	})
end

return Plugin
