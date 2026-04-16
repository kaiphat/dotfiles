local state = {}

local function build_path(git_branch, cwd)
	local file_name = string.format('kaiphat_anchor:%s:%s.json', cwd, git_branch or 'nobranch')
	local escaped = string.gsub(file_name, '[\\/]', '_')
	return string.format('%s/%s', vim.fn.stdpath 'data', escaped)
end

local function save()
	if not state.was_changed then
		return
	end

	state.path:write(vim.json.encode(state.anchors), 'w')
	state.was_changed = false
end

local function get_buf_anchor_index(file)
	for index, anchor in pairs(state.anchors) do
		if anchor.path == file then
			return index
		end
	end
end

local function get_anchor_index()
	return state.current_buf_anchor_index
end

local function load()
	if state.loaded then
		return
	end

	state.git_branch = __.utils.get_git_branch()
	state.cwd = __.utils.get_root_dir()
	state.path = require('plenary.path'):new(build_path(state.git_branch, state.cwd))
	state.group = __.utils.create_augroup 'anchor'

	if state.path:exists() then
		state.anchors = vim.json.decode(state.path:read())
	else
		state.anchors = {}
	end

	state.current_buf_anchor_index = get_buf_anchor_index(__.utils.get_full_path())
	state.loaded = true

	vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
		group = state.group,
		pattern = '*',
		callback = save,
	})

	vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
		group = state.group,
		pattern = '*',
		callback = function(event)
			if event.file == '' then
				return
			end

			state.current_buf_anchor_index = get_buf_anchor_index(event.file)
		end,
	})
end

local function remove_anchor(index)
	load()

	state.anchors[index] = nil
	state.was_changed = true
end

local function add_anchor()
	load()

	local ok, key = pcall(vim.fn.getchar)

	if not ok then
		return
	end

	if type(key) ~= 'number' then
		return
	end

	local char = vim.fn.nr2char(key)

	local row, col = __.utils.get_row_col()
	local current_path = __.utils.get_full_path()

	for index, anchor in pairs(state.anchors) do
		if anchor.path == current_path and index ~= char then
			remove_anchor(index)
			break
		end
	end

	state.anchors[char] = {
		row = row,
		col = col,
		path = current_path,
	}
	state.was_changed = true
	state.current_buf_anchor_index = char

	vim.notify('Marked as ' .. char)
end

local function go_to_anchor()
	load()

	local ok, key = pcall(vim.fn.getchar)

	if not ok then
		return
	end

	if type(key) ~= 'number' then
		return
	end

	local char = vim.fn.nr2char(key)

	local anchor = state.anchors[char]

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

local function show_anchors()
	load()

	__.load_plugin 'snacks'

	Snacks.picker {
		finder = function()
			local items = {}
			for anchor_index, item in pairs(state.manager.anchors) do
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
					remove_anchor(selected.anchor_index)
				end
				picker:find()
			end,
		},
	}
end

return {
	setup = function()
		vim.schedule(function()
			load()
		end)
	end,
	add_anchor = add_anchor,
	go_to_anchor = go_to_anchor,
	show_anchors = show_anchors,
	get_anchor_index = get_anchor_index,
}
