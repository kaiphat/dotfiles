local H = {}

H.timer = vim.loop.new_timer()

H.window_matches = {}

H.create_autocommands = function()
	local gr = vim.api.nvim_create_augroup('MiniCursorword', {})

	local au = function(event, pattern, callback, desc)
		vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
	end

	au('CursorMoved', '*', H.auto_highlight, 'Auto highlight cursorword')
	au({ 'InsertEnter', 'TermEnter', 'QuitPre' }, '*', H.auto_unhighlight, 'Auto unhighlight cursorword')
	au('ModeChanged', '*:[^i]', H.auto_highlight, 'Auto highlight cursorword')
end

--stylua: ignore
H.create_default_hl = function()
    vim.api.nvim_set_hl(0, 'MiniCursorword',        { default = true, underline = true })
    vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { default = true, link = 'MiniCursorword' })
end

H.is_disabled = function()
	local curword = vim.fn.expand '<cword>'
	local filetype = vim.bo.filetype

	local blocklist = {}

	if filetype == 'aerial' then
		return true
	elseif filetype == 'lua' then
		blocklist = { 'local', 'require' }
	elseif filetype == 'javascript' or filetype == 'typescript' then
		blocklist = { 'import' }
	end

	return vim.tbl_contains(blocklist, curword)
end

H.auto_highlight = function()
	-- Stop any possible previous delayed highlighting
	H.timer:stop()

	-- Stop highlighting immediately if module is disabled when cursor is not on
	-- 'keyword'
	if not H.should_highlight() then
		return H.unhighlight()
	end

	-- Get current information
	local win_id = vim.api.nvim_get_current_win()
	local win_match = H.window_matches[win_id] or {}
	local curword = H.get_cursor_word()

	-- Only immediately update highlighting of current word under cursor if
	-- currently highlighted word equals one under cursor
	if win_match.word == curword then
		H.unhighlight(true)
		H.highlight(true)
		return
	end

	-- Stop highlighting previous match (if it exists)
	H.unhighlight()

	-- Delay highlighting
	H.timer:start(
		400,
		0,
		vim.schedule_wrap(function()
			-- Ensure that always only one word is highlighted
			H.unhighlight()
			H.highlight()
		end)
	)
end

H.auto_unhighlight = function()
	H.timer:stop()
	H.unhighlight()
end

H.highlight = function(only_current)
	local win_id = vim.api.nvim_get_current_win()
	if not vim.api.nvim_win_is_valid(win_id) then
		return
	end

	if not H.should_highlight() then
		return
	end

	H.window_matches[win_id] = H.window_matches[win_id] or {}

	-- Add match highlight for current word under cursor
	local current_word_pattern = [[\k*\%#\k*]]
	local match_id_current = vim.fn.matchadd('MiniCursorwordCurrent', current_word_pattern, -1)
	H.window_matches[win_id].id_current = match_id_current

	-- Don't add main match id if not needed or if one is already present
	if only_current or H.window_matches[win_id].id ~= nil then
		return
	end

	local curword = H.get_cursor_word()
	local pattern = string.format([[\(%s\)\@!\&\V\<%s\>]], current_word_pattern, curword)
	local match_id = vim.fn.matchadd('MiniCursorword', pattern, -1)

	-- Store information about highlight
	H.window_matches[win_id].id = match_id
	H.window_matches[win_id].word = curword
end

H.unhighlight = function(only_current)
	-- Don't do anything if there is no valid information to act upon
	local win_id = vim.api.nvim_get_current_win()
	local win_match = H.window_matches[win_id]
	if not vim.api.nvim_win_is_valid(win_id) or win_match == nil then
		return
	end

	-- Use `pcall` because there is an error if match id is not present. It can
	-- happen if something else called `clearmatches`.
	pcall(vim.fn.matchdelete, win_match.id_current)
	H.window_matches[win_id].id_current = nil

	if not only_current then
		pcall(vim.fn.matchdelete, win_match.id)
		H.window_matches[win_id] = nil
	end
end

H.should_highlight = function()
	return not H.is_disabled() and H.is_cursor_on_keyword()
end

H.error = function(msg)
	error('(mini.cursorword) ' .. msg, 0)
end

H.check_type = function(name, val, ref, allow_nil)
	if type(val) == ref or (ref == 'callable' and vim.is_callable(val)) or (allow_nil and val == nil) then
		return
	end
	H.error(string.format('`%s` should be %s, not %s', name, ref, type(val)))
end

H.is_cursor_on_keyword = function()
	local col = vim.fn.col '.'
	local curchar = vim.api.nvim_get_current_line():sub(col, col)

	-- Use `pcall()` to catch `E5108` (can happen in binary files, see #112)
	local ok, match_res = pcall(vim.fn.match, curchar, '[[:keyword:]]')
	return ok and match_res >= 0
end

H.get_cursor_word = function()
	return vim.fn.escape(vim.fn.expand '<cword>', [[\/]])
end

return {
	setup = function()
		H.create_autocommands()
		H.create_default_hl()
	end,
}
