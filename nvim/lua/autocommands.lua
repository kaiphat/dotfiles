vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
	group = vim.api.nvim_create_augroup('last_position', {}),
	callback = function()
		local test_line_data = vim.api.nvim_buf_get_mark(0, '"')
		local test_line = test_line_data[1]
		local last_line = vim.api.nvim_buf_line_count(0)

		if test_line > 0 and test_line <= last_line then vim.api.nvim_win_set_cursor(0, test_line_data) end
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.highlight.on_yank { timeout = 700 } end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = vim.api.nvim_create_augroup('auto_create_dir', {}),
	callback = function(event)
		if event.match:match '^%w%w+://' then return end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('set_number', {}),
	pattern = 'norg',
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	group = vim.api.nvim_create_augroup('set_format_options', {}),
	callback = function()
		vim.opt_local.formatoptions = 'tc'
	end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
	group = vim.api.nvim_create_augroup('autosave', {}),
	pattern = '*.norg',
	callback = function() vim.cmd 'silent! write' end,
})
