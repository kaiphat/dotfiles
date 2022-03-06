local utils = require('utils')
local logger = require('utils.logger')

local map = utils.map
local bindArgs = utils.bindArgs

vim.g.mapleader = ' '

map('n', '<leader>ee', ":NvimTreeFindFile<cr>")
map('n', '<leader>ec', function()
  vim.cmd 'lcd ~/dotfiles/nvim'
  vim.cmd 'Telescope find_files'
end)
map('n', '<leader>en', ':lua require"telescope.builtin".find_files({ cwd = "~/notes" })<cr>')

map('n', '<F1>', ":w<cr>:e ++ff=dos<cr>:w ++ff=unix<cr>")
map('n', '<F9>', ':LspRestart<cr>')

map('n', ':', ';')
map('n', ';', ':', { noremap = true })
map('v', ':', ';')
map('v', ';', ':', { noremap = true })

map('v', 'p', 'pgvy')
map('c', '<C-r>', '<C-r>+', { noremap = false })
map('i', '<C-r>', '<F3><C-r>+<F3>', { noremap = false })

map('n', '<C-h>', ':wincmd h<cr>')
map('n', '<C-j>', ':wincmd j<cr>')
map('n', '<C-k>', ':wincmd k<cr>')
map('n', '<C-l>', ':wincmd l<cr>')
map('n', '<C-[>', ':bp<cr>')
map('n', '<C-]>', ':bn<cr>')

map('n', '<C-s>', ':wa<cr>')

map('n', 'cl', 'ct')
map('n', 'dl', 'dt')
map('n', 'yl', 'yt')
map('n', 'vl', 'vt')
map('n', '<A-j>', ':wincmd l<cr>')

map('n', '<A-->', ':vertical resize -10<cr>')
map('n', '<A-=>', ':vertical resize +10<cr>')

map('n', '<A-j>', ':m .+1<cr>==')
map('n', '<A-k>', ':m .-2<cr>==')
map('v', '<A-k>', ":m '<-2<cr>gv=gv")
map('v', '<A-j>', ":m '>+1<cr>gv=gv")

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

-- map('n', '<Enter>', '@j') -- ???
map('n', ',', '^') -- ???
map('n', 'Q', 'q')

map('n', '<leader>sd', "koconsole.log('\\x1b[36m%s\\x1b[0m',)<esc>F,a ")
map('n', '<leader>sc', "koconsole.log('\\x1b[36m%s\\x1b[0m', JSON.stringify({}, null, 2))<esc>F{a")
map('n', '<leader>sl', "koconsole.log({})<esc>F{a")

map('o', 'w', 'iw')
map('o', "'", "i'")
map('o', '"', 'i"')
map('o', '`', 'i`')
map('o', '(', 'i(')
map('o', '{', 'i{')
map('o', '[', 'i[')

map('x', 'w', 'iw')
map('x', "'", "i'")
map('x', '"', 'i"')
map('x', '`', 'i`')
map('x', '(', 'i(')
map('x', '{', 'i{')
map('x', '[', 'i[')

-- utils
map('v', '<leader>uaq', ':EasyAlign /\\C["(a-z:\']/ {"rm": 0} <cr>')
map('n', '<leader>ut', function()
  vim.cmd '%s/\\s\\+$//'
end)

-- telescope
map('n', '<leader>ff', ':lua require"telescope.builtin".find_files({ hidden = true, no_ignore = true })<cr>')
map('n', '<leader>fe', ':lua require"telescope".extensions.file_browser.file_browser({ hidden = true })<cr>')
map('n', '<leader>fg', ':lua require"telescope.builtin".live_grep({ max_results = 50 })<cr>')
map('n', '<leader>fb', ':Telescope buffers<cr>')
map('n', '<leader>fs', ':Telescope git_status<cr>')
map('n', '<leader>fr', ':Telescope lsp_references<cr>')
map('n', '<leader>fo', ':Telescope oldfiles<cr>')
map('n', '<leader>fp', ':Telescope resume<cr>')
map('n', '<leader>fm', ':Telescope marks<cr>')
map('n', '<leader>fh', function()
  local path = utils.getCurrentPath()
  require'telescope'.extensions.file_browser.file_browser { cwd = path, hidden = true }
end)

-- nvim tree
map('n', '<leader>o', ':NvimTreeToggle<cr>')

-- hop
map('n', '<leader>j', ':HopChar1<cr>')

-- marks
local letters = 'abcdefghijklmnopqrstuvwxyz'
for i = 1, #letters do
    local letter = letters:sub(i, i)
    map('n', 'm'..letter, 'm'..letter:upper())
    map('n', "'"..letter, "'"..letter:upper())
end

-- treesitter unit
map('x', 'u', ':lua require"utils.unit".select(true)<cr>')
map('o', 'u', ':<c-u>lua require"utils.unit".select(true)<cr>')
map('n', ']', ':lua require"utils.unit".moveToEnd()<cr>')
map('n', '[', ':lua require"utils.unit".moveToStart()<cr>')

vim.cmd("silent! command PackerStatus lua require 'plugins_list' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugins_list' require('packer').sync()")
