local M = {}

map('n', '<F1>', ':w<cr>:e ++ff=dos<cr>:w ++ff=unix<cr>')
map('n', '<F9>', ':LspRestart<cr>')

local is_wrapped = false
map('n', '<F4>', function()
  if is_wrapped then
    vim.cmd 'set nowrap'
  else
    vim.cmd 'set wrap'
  end
  is_wrapped = not is_wrapped
end)

map('v', 'y', 'ygv<esc>')
map('v', 'p', 'pgvy=`]')
map('v', '<', '<gv')
map('v', '>', '>gv')
map('n', '\'', '`')

map({ 'c', 'i' }, '<C-r>', '<C-r>+', { noremap = false })

map('n', '<C-h>', ':wincmd h<cr>')
map('n', '<C-j>', ':wincmd j<cr>')
map('n', '<C-k>', ':wincmd k<cr>')
map('n', '<C-l>', ':wincmd l<cr>')

map('n', 'i', function()
  if #vim.fn.getline '.' == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true })

map('n', 'H', '^')
map('n', 'L', '$')

map('n', '<C-s>', ':wa<cr>')

map('n', '<C-d>', function()
  vim.api.nvim_feedkeys('4j', 'n', true)
end)
map('n', '<C-u>', function()
  vim.api.nvim_feedkeys('4k', 'n', true)
end)

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

map('i', 'ne', '<esc>')
map('i', 'en', '<esc>')
map('i', 'Ne', '<esc>')
map('i', 'En', '<esc>')
map('i', 'EN', '<esc>')

map('i', '<C-l>', '<Right><c-h>')
map('i', '<C-d>', '<Right>')

map('n', '<esc>', ':nohl<cr>')

map('n', 'Y', 'y$')

map('n', 'J', 'Jzz')

map('n', ',,', '^')
map('n', ',s', ':split<cr>')
map('n', ',v', ':vsplit<cr>')
map('n', ',x', ':q<cr>')

for char in string.gmatch([[w'"`p[<({]], '.') do
  for command in string.gmatch('ydvc', '.') do
    map('n', command .. char, command .. 'i' .. char)
  end
end

M.is_root = true
M.root_path = get_current_path()

map('n', '<leader>ur', function()
  if M.is_root then
    vim.cmd('lcd ' .. get_current_path())
    vim.notify 'cwd changed to current place'
    M.is_root = false
  else
    vim.cmd('lcd ' .. M.root_path)
    vim.notify 'cwd changed to root'
    M.is_root = true
  end
end)

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     marks     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

for letter in string.gmatch('abcdefghijkloqrstuvwxyz', '.') do
  map('n', 'm' .. letter, 'm' .. letter:upper())
  map('n', '\'' .. letter, '\'' .. letter:upper())
end

map('n', '<leader>lw', function()
  local ft = vim.bo.filetype

  local var = vim.fn.expand '<cword>'
  local row = get_row_col()

  local new_line
  if ft == 'typescript' or ft == 'javascript' then
    new_line = 'console.log(\''..var ..': %o\', '.. var ..')'
  elseif ft == 'rust' then
    new_line = 'println!("\\x1b[36m' .. var .. ': {:?}\\x1b[0m", ' .. var .. ');'
  end

  vim.api.nvim_buf_set_lines(0, row, row, true, { new_line })
  vim.cmd.normal 'j=='
end)

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     utils     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

map('n', '<leader>uf', function()
  print(vim.bo.filetype)
end)
