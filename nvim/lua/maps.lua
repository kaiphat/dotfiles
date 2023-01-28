local u = require 'utils'

map('n', '<F1>', ":w<cr>:e ++ff=dos<cr>:w ++ff=unix<cr>")
map('n', '<F9>', ':LspRestart<cr>')

map({ 'v', 'n' }, ':', ';')
map({ 'v', 'n' }, ';', ':', { noremap = true })

map('v', 'p', 'pgvy')
map('c', '<C-r>', '<C-r>+', { noremap = false })
map('i', '<C-r>', '<F3><C-r>+<F3>', { noremap = false })

map('n', '<C-h>', ':wincmd h<cr>')
map('n', '<C-j>', ':wincmd j<cr>')
map('n', '<C-k>', ':wincmd k<cr>')
map('n', '<C-l>', ':wincmd l<cr>')

map('n', '<C-s>', ':wa<cr>')

map('n', 'cl', 'ct')
map('n', 'dl', 'dt')
map('n', 'yl', 'yt')
map('n', 'vl', 'vt')

map('n', '<A-->', ':vertical resize -10<cr>')
map('n', '<A-=>', ':vertical resize +10<cr>')

map('n', '<A-J>', ':m .+1<cr>==')
map('v', '<A-J>', ":m '>+1<cr>gv=gv")
map('v', '<A-K>', ":m '<-2<cr>gv=gv")
map('n', '<A-K>', ':m .-2<cr>==')

map('i', 'jk', "<esc>")
map('i', 'kj', "<esc>")
map('i', 'Kj', "<esc>")
map('i', 'kJ', "<esc>")

map('i', '<C-l>', "<Right><c-h>")
map('i', '<C-d>', "<Right>")

map('n', '<esc>', ":nohl<cr>")

map('n', 'Y', 'y$')

-- map('n', 'n', 'nzz')
-- map('n', 'N', 'Nzz')
map('n', 'J', 'Jzz')
-- map('n', '*', '*zz')
-- map('n', '#', '#zz')

map('n', ',,', '^')
map('n', ',s', ':split<cr>')
map('n', ',v', ':vsplit<cr>')
map('n', ",x", ':q<cr>')

map('n', 'Q', 'q')

for char in string.gmatch('w\'"`p<({[', '.') do
  for command in string.gmatch('ydvc', '.') do
    map('n', command .. char, command .. 'i' .. char)
  end
end

-- utils
map('n', '<leader>ut', function()
  vim.cmd '%s/\\s\\+$//'
end)
map('n', '<leader>uus', function() -- upper sql
  vim.cmd '%s/.*/\\=v:lua.upperSql(submatch(0))'
  vim.cmd 'nohl'
end)

local root_path = u.get_current_path()

map('n', '<leader>uc', function()
  local path = u.get_current_path()
  vim.cmd('lcd ' .. path)
  vim.notify(' cwd changed to current place')
end)

map('n', '<leader>ur', function()
  vim.cmd('lcd ' .. root_path)
  vim.notify(' cwd changed to root')
end)

-- marks
for letter in string.gmatch('abcdefghijkloqrstuvwxyz', '.') do
  map('n', 'm' .. letter, 'm' .. letter:upper())
  map('n', "'" .. letter, "'" .. letter:upper())
end
