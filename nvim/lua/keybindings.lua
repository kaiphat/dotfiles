local logger = require('utils.logger')

vim.g.mapleader = ' '

map('n', '<leader>ee', ":NvimTreeFindFile<cr>")

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

map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', 'J', 'Jzz')
map('n', '*', '*zz')
map('n', '#', '#zz')

map('n', ',,', '^')
map('n', 'Q', 'q')

map({ 'o', 'x' }, 'w', 'iw')
map({ 'o', 'x' }, "'", "i'")
map({ 'o', 'x' }, '"', 'i"')
map({ 'o', 'x' }, '`', 'i`')
map({ 'o', 'x' }, '(', 'i(')
map({ 'o', 'x' }, '{', 'i{')
map({ 'o', 'x' }, '[', 'i[')

-- utils
map('v', '<leader>uaq', ':EasyAlign /\\C["(a-z:\']/ {"rm": 0} <cr>')
map('n', '<leader>ut', function()
  vim.cmd '%s/\\s\\+$//'
end)
map('x', '<leader>uus', ':s/.*/\\=v:lua.upperSql(submatch(0))/g<cr>:nohl<cr>')
map('n', '<leader>uus', function() -- upper sql
  vim.cmd '%s/.*/\\=v:lua.upperSql(submatch(0))'
  vim.cmd 'nohl'
end)

-- luasnip
map({'i', 's'}, '<C-e>', function()
  require("luasnip").jump(1)
end)

-- nvim tree
map('n', '<leader>o', ':NvimTreeToggle<cr>')

-- marks
local letters = 'abcdefghijklmnopqrstuvwxyz'
for i = 1, #letters do
    local letter = letters:sub(i, i)
    map('n', 'm'..letter, 'm'..letter:upper())
    map('n', "'"..letter, "'"..letter:upper())
end

-- focus
map('n', '<leader>mt', function() require'focus'.focus_toggle() end)
map('n', ',v', function() vim.cmd 'vs' end)
map('n', ',s', function() vim.cmd 'sp' end)
map('n', ',x', function()
  vim.cmd 'q'
end)
map('n', ',X', function()
  vim.cmd 'wa'
  vim.cmd '%bd|e#'
end)

-- ts lsp utils
map('n', '<leader>ti', ':TSLspImportAll<cr>')
map('n', '<leader>tr', ':TSLspRenameFile<cr>')
map('n', '<leader>to', ':TSLspOrganize<cr>')

-- treesitter unit
map('x', 'u', ':lua require"utils.unit".select(true)<cr>')
map('o', 'u', ':<c-u>lua require"utils.unit".select(true)<cr>')
map('n', ']]', ':lua require"utils.unit".moveToEnd()<cr>')
map('n', '[[', ':lua require"utils.unit".moveToStart()<cr>')

vim.cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
