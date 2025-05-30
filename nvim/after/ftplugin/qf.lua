vim.keymap.set('n', 'dd', function()
	local curqfidx = vim.fn.line '.'
	local qfall = vim.fn.getqflist()

	if #qfall == 0 then
		vim.cmd 'cclose'
	end

	table.remove(qfall, curqfidx)
	vim.fn.setqflist(qfall, 'r')

	-- Reopen quickfix window to refresh the list
	vim.cmd 'copen'

	-- If not at the end of the list, stay at the same index, otherwise, go one up.
	local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)

	-- Set the cursor position directly in the quickfix window
	local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
	vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end, {
	buffer = 0,
})
