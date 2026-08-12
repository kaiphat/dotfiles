local _ = {}

_.timer = vim.loop.new_timer()

_.window_matches = {}

_.create_autocommands = function()
	local gr = __.utils.create_augroup 'cursorword'

	local au = function(event, pattern, callback, desc)
		vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
	end

	au('CursorMoved', '*', _.auto_highlight, 'Auto highlight cursorword')
	au({ 'InsertEnter', 'TermEnter', 'QuitPre' }, '*', _.auto_unhighlight, 'Auto unhighlight cursorword')
	au('ModeChanged', '*:[^i]', _.auto_highlight, 'Auto highlight cursorword')
end

_.create_default_hl = function()
	vim.api.nvim_set_hl(0, 'Cursorword', { link = 'Visual' })
end

_.is_disabled = function()
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

_.auto_highlight = function()
	-- Stop any possible previous delayed highlighting
	_.timer:stop()

	-- Stop highlighting immediately if module is disabled when cursor is not on
	-- 'keyword'
	if not _.should_highlight() then
		return _.unhighlight()
	end

	-- Get current information
	local win_id = vim.api.nvim_get_current_win()
	local win_match = _.window_matches[win_id] or {}
	local curword = _.get_cursor_word()

	-- Only immediately update highlighting of current word under cursor if
	-- currently highlighted word equals one under cursor
	if win_match.word == curword then
		_.unhighlight(true)
		_.highlight(true)
		return
	end

	-- Stop highlighting previous match (if it exists)
	_.unhighlight()

	-- Delay highlighting
	_.timer:start(
		400,
		0,
		vim.schedule_wrap(function()
			-- Ensure that always only one word is highlighted
			_.unhighlight()
			_.highlight()
		end)
	)
end

_.auto_unhighlight = function()
	_.timer:stop()
	_.unhighlight()
end

_.highlight = function(only_current)
	local win_id = vim.api.nvim_get_current_win()
	if not vim.api.nvim_win_is_valid(win_id) then
		return
	end

	if not _.should_highlight() then
		return
	end

	_.window_matches[win_id] = _.window_matches[win_id] or {}

	-- Add match highlight for current word under cursor
	local current_word_pattern = [[\k*\%#\k*]]
	local match_id_current = vim.fn.matchadd('Cursorword', current_word_pattern, -1)
	_.window_matches[win_id].id_current = match_id_current

	-- Don't add main match id if not needed or if one is already present
	if only_current or _.window_matches[win_id].id ~= nil then
		return
	end

	local curword = _.get_cursor_word()
	local pattern = string.format([[\(%s\)\@!\&\V\<%s\>]], current_word_pattern, curword)
	local match_id = vim.fn.matchadd('Cursorword', pattern, -1)

	-- Store information about highlight
	_.window_matches[win_id].id = match_id
	_.window_matches[win_id].word = curword
end

_.unhighlight = function(only_current)
	-- Don't do anything if there is no valid information to act upon
	local win_id = vim.api.nvim_get_current_win()
	local win_match = _.window_matches[win_id]
	if not vim.api.nvim_win_is_valid(win_id) or win_match == nil then
		return
	end

	-- Use `pcall` because there is an error if match id is not present. It can
	-- happen if something else called `clearmatches`.
	pcall(vim.fn.matchdelete, win_match.id_current)
	_.window_matches[win_id].id_current = nil

	if not only_current then
		pcall(vim.fn.matchdelete, win_match.id)
		_.window_matches[win_id] = nil
	end
end

_.should_highlight = function()
	return not _.is_disabled() and _.is_cursor_on_keyword()
end

_.is_cursor_on_keyword = function()
	local col = vim.fn.col '.'
	local curchar = vim.api.nvim_get_current_line():sub(col, col)

	-- Use `pcall()` to catch `E5108` (can happen in binary files, see #112)
	local ok, match_res = pcall(vim.fn.match, curchar, '[[:keyword:]]')
	return ok and match_res >= 0
end

_.get_cursor_word = function()
	return vim.fn.escape(vim.fn.expand '<cword>', [[\/]])
end

return {
	setup = function()
		_.create_autocommands()
		_.create_default_hl()
	end,
}
