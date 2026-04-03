local Manager = require 'local_plugins.anchor.Manager'

local function map(keys, cmd)
	vim.keymap.set('n', keys, cmd, { noremap = true, silent = true })
end

local Plugin = {}

Plugin.__index = Plugin

function Plugin:new()
	return setmetatable({
		group = __.utils.create_augroup 'anchor_plugin_group',
		current_buf_anchor_index = nil,
	}, self)
end

function Plugin:create_manager()
	self.manager = Manager:new {
		git_branch = __.utils.get_git_branch(),
		cwd = __.utils.get_root_dir(),
	}
	self.manager:setup()
end

function Plugin:add_keymaps()
	map('m', function()
		local ok, key = pcall(vim.fn.getchar)

		if not ok then
			return
		end

		if type(key) == 'number' then
			local char = vim.fn.nr2char(key)

			self.manager:add_anchor(char)
			self.current_buf_anchor_index = char

			vim.notify('Marked as ' .. char)
		end
	end)

	map([[']], function()
		local ok, key = pcall(vim.fn.getchar)

		if not ok then
			return
		end

		if type(key) == 'number' then
			local char = vim.fn.nr2char(key)

			self.manager:load_buffer(char)
		end
	end)

	map('<leader>bs', function()
		Snacks.picker {
			finder = function()
				local items = {}
				for anchor_index, item in pairs(self.manager.anchors) do
					table.insert(items, {
						idx = anchor_index,
						anchor_index = anchor_index,
						score = 1,
						file = item.path,
					})
				end
				return items
			end,
			format = function(item)
				local ret = {}
				ret[#ret + 1] = { item.anchor_index .. '  ', 'SnacksPickerLabel' }
				ret[#ret + 1] = { vim.fn.fnamemodify(item.file, ':~:.'), 'SnacksPickerComment' }
				return ret
			end,
			win = {
				input = {
					keys = {
						['<c-d>'] = { 'delete_anchor', mode = { 'n', 'i' } },
					},
				},
			},
			actions = {
				delete_anchor = function(picker)
					for _, selected in ipairs(picker:selected { fallback = true }) do
						self.manager:remove_anchor(selected.anchor_index)
					end
					picker:find()
				end,
			},
		}
	end)
end

function Plugin:get_anchor_index()
	return self.current_buf_anchor_index
end

function Plugin:setup()
	self:create_manager()

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

	self:add_keymaps()
end

return Plugin
