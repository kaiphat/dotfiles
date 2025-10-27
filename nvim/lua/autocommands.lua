-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
	group = kaiphat.utils.create_augroup 'checktime',
	callback = function()
		if vim.o.buftype ~= 'nofile' then
			vim.cmd 'checktime'
		end
	end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
	group = kaiphat.utils.create_augroup 'last_position',
	callback = function()
		local test_line_data = vim.api.nvim_buf_get_mark(0, '"')
		local test_line = test_line_data[1]
		local last_line = vim.api.nvim_buf_line_count(0)

		if test_line > 0 and test_line <= last_line then
			vim.api.nvim_win_set_cursor(0, test_line_data)
		end
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = kaiphat.utils.create_augroup 'text_yank_post',
	callback = function()
		vim.highlight.on_yank { timeout = 100 }
	end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = kaiphat.utils.create_augroup 'auto_create_dir',
	callback = function(event)
		if event.match:match '^%w%w+://' then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
	group = kaiphat.utils.create_augroup 'json_conceal',
	pattern = { 'json', 'jsonc', 'json5' },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'VimLeavePre' }, {
	group = kaiphat.utils.create_augroup 'autosave',
	callback = function(event)
		if vim.bo.filetype == 'oil' then
			return
		end

		if event.file == '' then
			return
		end

		local buf = event.buf
		if vim.api.nvim_get_option_value('modified', { buf = buf }) then
			vim.schedule(function()
				vim.api.nvim_buf_call(buf, function()
					vim.cmd 'silent! write'
				end)
			end)
		end
	end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- 	group = kaiphat.utils.create_augroup 'set_format_options',
-- 	callback = function(file)
-- 		vim.opt_local.formatoptions = 'tjcroql'
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
-- 	pattern = '*.md',
-- 	group = kaiphat.utils.create_augroup 'markdown_wrap_option',
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 	end,
-- })

local FOCUSED_WIDTH = 100
local MIN_WIDTH = 5
local SUPPORTED_BUF_TYPES = {
	[''] = true,
	acwrite = true,
}

-- vim.api.nvim_create_autocmd({ 'WinEnter', 'VimResized' }, {
-- 	callback = function()
-- 		local curwin = vim.api.nvim_get_current_win()
-- 		local currow = vim.api.nvim_win_get_position(curwin)[1]
--
-- 		local tabpage = vim.api.nvim_get_current_tabpage()
-- 		local wins = vim.api.nvim_tabpage_list_wins(tabpage)
--
-- 		local same_row_wins = {}
--
-- 		-- idea: sort by the left and min width
-- 		-- then left only with unique left
-- 		-- compare left of the current win and another wins
-- 		--
-- 		-- the main idea to change width of the current windows
-- 		-- due changing width of the smallest windows
--
-- 		-- create table with windows and set for every window width equality parts like width_parts = 3
-- 		-- and the need to set width at first for wins with the biggest width
--
-- 		-- event better to separate wins like them separated in splits
-- 		-- then calculate width for every split
-- 		--k  and then calculate width for every win
-- 		-- and set width for every win
--
-- 		for _, win in ipairs(wins) do
-- 			local buf = vim.api.nvim_win_get_buf(win)
-- 			local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
--
-- 			if not SUPPORTED_BUF_TYPES[buftype] then
-- 				goto continue
-- 			end
--
-- 			local top_row, col = unpack(vim.api.nvim_win_get_position(win))
-- 			local height = vim.api.nvim_win_get_height(win)
-- 			local bottom_row = top_row + height
--
-- 			if top_row <= currow and bottom_row > currow then
-- 				table.insert(same_row_wins, {
-- 					id = win,
-- 					col = col,
-- 					height = height,
-- 				})
-- 			end
--
-- 			::continue::
-- 		end
--
-- 		if #same_row_wins == 1 then
-- 			return
-- 		end
--
-- 		local total_width = vim.opt.columns:get()
-- 		local other_width = math.max(math.floor((total_width - FOCUSED_WIDTH) / (#same_row_wins - 1)), MIN_WIDTH)
--
-- 		for _, win in ipairs(same_row_wins) do
-- 			local new_width = win.id == curwin and FOCUSED_WIDTH or other_width
-- 			vim.api.nvim_win_set_width(win.id, new_width)
-- 		end
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd({ 'WinEnter', 'VimResized' }, {
-- 	callback = function()
-- 	end,
-- })

-- local function align()
-- 	local curwin = vim.api.nvim_get_current_win()
-- 	local currow = vim.api.nvim_win_get_position(curwin)[1]
--
-- 	local tabpage = vim.api.nvim_get_current_tabpage()
-- 	local raw_wins = vim.api.nvim_tabpage_list_wins(tabpage)
--
-- 	local wins = {}
--
-- 	for _, win in ipairs(raw_wins) do
-- 		local buf = vim.api.nvim_win_get_buf(win)
-- 		local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
--
-- 		if not SUPPORTED_BUF_TYPES[buftype] then
-- 			goto continue
-- 		end
--
-- 		local top, left = unpack(vim.api.nvim_win_get_position(win))
-- 		local height = vim.api.nvim_win_get_height(win)
-- 		local width = vim.api.nvim_win_get_width(win)
--
-- 		table.insert(wins, {
-- 			id = win,
-- 			left = left,
-- 			rigth = left + width,
-- 			top = top,
-- 			height = height,
-- 			width = width,
-- 		})
--
-- 		::continue::
-- 	end
--
-- 	if #wins == 1 then
-- 		return
-- 	end
--
-- 	for _, win in ipairs(wins) do
-- 		for _, w in ipairs(wins) do
-- 			if w.id ~= win.id and w.left >= win.left and w.
-- 		end
-- 	end
-- end
--
-- align()
--
-- vim.api.nvim_create_autocmd({ 'WinEnter', 'VimResized' }, {
-- 	callback = function()
-- 		vim.cmd 'wincmd ='
-- 	end,
-- })
