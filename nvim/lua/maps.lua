local map = function(mode, keys, cmd, opts)
	opts = opts or { noremap = true, silent = true }
	vim.keymap.set(mode, keys, cmd, opts)
end

map('v', 'y', 'ygv<esc>')
map('v', 'p', 'pgvy=`]')
map('v', '<', '<gv')
map('v', '>', '>gv')
map('n', '\'', '`')
map('n', '<C-Q>', '<cmd>wqa<cr>')
map('n', 'J', function()
	vim.api.nvim_feedkeys('J', 'n', false)

	vim.schedule(function()
		local col = vim.fn.col '.'
		local row = vim.fn.getline '.'
		local char = string.sub(row, col, col)

		if char == ' ' then
			vim.api.nvim_feedkeys('x', 'n', false)
		end
	end)
end)

map({ 'c', 'i' }, '<C-r>', '<C-r>+', { noremap = false })
map('n', '<C-h>', '<cmd>wincmd h<cr>')
map('n', '<C-j>', '<cmd>wincmd j<cr>')
map('n', '<C-k>', '<cmd>wincmd k<cr>')
map('n', '<C-l>', '<cmd>wincmd l<cr>')

map('n', 'i', function()
	if #vim.fn.getline '.' == 0 then
		return [["_cc]]
	else
		return 'i'
	end
end, { expr = true })

map('n', 'H', '^')
map('n', 'L', '$')

map('n', '<C-s>', function()
	vim.cmd 'w'
end)

map({ 'n', 'v' }, '<C-d>', '3j')
map({ 'n', 'v' }, '<C-u>', '3k')

map('n', 'x', function()
	if vim.fn.col '.' == 1 then
		local line = vim.fn.getline '.'
		if line:match '^%s*$' then
			vim.api.nvim_feedkeys('dd', 'n', false)
			vim.api.nvim_feedkeys('$', 'n', false)
		else
			vim.api.nvim_feedkeys('"_x', 'n', false)
		end
	else
		vim.api.nvim_feedkeys('"_x', 'n', false)
	end
end)

map('n', '<A-->', ':vertical resize -10<cr>')
map('n', '<A-=>', ':vertical resize +10<cr>')
map('n', '<A-J>', ':m .+1<cr>==')
map('v', '<A-J>', ':m \'>+1<cr>gv=gv')
map('v', '<A-K>', ':m \'<-2<cr>gv=gv')
map('n', '<A-K>', ':m .-2<cr>==')

local escape_chars = { 'n', 'e' }
escape_chars = { 'j', 'k' }
map('i', escape_chars[1] .. escape_chars[2], '<esc>')
map('i', escape_chars[2] .. escape_chars[1], '<esc>')
map('i', escape_chars[1]:upper() .. escape_chars[2], '<esc>')
map('i', escape_chars[2]:upper() .. escape_chars[1], '<esc>')
map('i', escape_chars[1]:upper() .. escape_chars[2]:upper(), '<esc>')

map('i', '<C-l>', '<Right><c-h>')
map('i', '<C-d>', '<Right>')

map('n', '<esc>', ':nohl<cr>')

map('n', 'Y', 'y$')

map('n', ',,', '^')
map('n', ',s', '<cmd>split<cr>')
map('n', ',v', '<cmd>vsplit<cr>')
map('n', ',x', function()
	vim.cmd 'silent! wq'
end)

for char in string.gmatch([[w'"`p[<({]], '.') do
	for command in string.gmatch('ydvc', '.') do
		map('n', command .. char, command .. 'i' .. char)
	end
end

local is_root = true
local root_path

map('n', '<leader>ur', function()
	if is_root then
		vim.cmd('lcd ' .. kaiphat.utils.get_current_dir())
		vim.notify 'cwd changed to current place'
		is_root = false
		root_path = kaiphat.utils.get_current_dir()
	else
		vim.cmd('lcd ' .. root_path)
		vim.notify 'cwd changed to root'
		is_root = true
	end
end)

map('n', '<leader>lw', function()
	local ft = vim.bo.filetype

	local var = vim.fn.expand '<cword>'
	local row = kaiphat.utils.get_row_col()

	local new_line
	if ft == 'typescript' or ft == 'javascript' then
		new_line = 'console.log(\'%o\', {' .. var .. '})'
	elseif ft == 'rust' then
		new_line = 'println!("\\x1b[36m' .. var .. ': {:?}\\x1b[0m", ' .. var .. ');'
	end

	vim.api.nvim_buf_set_lines(0, row, row, true, { new_line })
	vim.cmd.normal 'j=='
end)

map('n', '<leader>us', function()
	vim.api.nvim_input ':%s/'
end)
map('v', '<leader>us', function()
	vim.api.nvim_input ':s/'
end)
local function substitute()
	local start_pos = vim.fn.getpos 'v'
	local end_pos = vim.fn.getpos '.'

	local line = vim.fn.getline(start_pos[2])
	local word = vim.trim(string.sub(line, start_pos[3], end_pos[3]))

	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { word })

	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)

	vim.keymap.set('n', 'q', function()
		vim.cmd 'q'
	end, { buffer = bufnr })

	local clear_enter = false
	vim.keymap.set('n', '<esc>', function()
		clear_enter = true
		vim.cmd 'q'
	end, { buffer = bufnr })

	vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
		buffer = bufnr,
		callback = function()
			if clear_enter then
				return
			end
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local new_word = vim.trim(lines[1])
			vim.schedule(function()
				vim.cmd('let @/="' .. word .. '"') -- path to register to call witn n or p
				vim.cmd('let @+="' .. new_word .. '"')
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes('cgn' .. new_word .. '<esc>', true, false, true),
					'',
					true
				)
			end)
		end,
	})

	local word_width = math.max(#word, 20)
	vim.api.nvim_open_win(bufnr, true, {
		relative = 'editor',
		width = word_width,
		height = 1,
		col = math.ceil((width - word_width) / 2),
		row = math.ceil(height / 2),
		style = 'minimal',
		border = 'rounded',
		title = 'Replace',
		title_pos = 'center',
	})
end
map('n', '<leader>uw', function()
	vim.api.nvim_input 'viw'
	vim.schedule(function()
		substitute()
	end)
end)
map('v', '<leader>uw', function()
	substitute()
end)

map('n', 'zf', function()
	vim.cmd.normal 'zMzr'
end)
map('n', 'zo', function()
	vim.cmd.normal 'zO'
end)
