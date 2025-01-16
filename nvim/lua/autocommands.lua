local u = require 'utils'

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
	group = u.create_augroup 'last_position',
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
	group = u.create_augroup 'text_yank_post',
	callback = function()
		vim.highlight.on_yank { timeout = 700 }
	end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = u.create_augroup 'auto_create_dir',
	callback = function(event)
		if event.match:match '^%w%w+://' then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- 	group = u.create_augroup 'set_format_options',
-- 	callback = function(file)
-- 		vim.opt_local.formatoptions = 'tc'
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
-- 	pattern = '*.md',
-- 	group = u.create_augroup 'markdown_wrap_option',
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 	end,
-- })

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'VimLeavePre' }, {
	group = u.create_augroup 'autosave',
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

-- vim.api.nvim_create_autocmd({ 'VimResized', 'WinEnter' }, {
-- 	group = u.create_augroup 'resize_pane',
-- 	callback = function(event)
-- 		vim.cmd 'wincmd ='
-- 		vim.cmd 'vertical resize +20'
-- 		vim.cmd 'horizontal resize +10'
-- 	end,
-- })
