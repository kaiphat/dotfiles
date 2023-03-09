local o = vim.opt
local g = vim.g

local home = os.getenv( "HOME" )

g.mapleader = ' '

o.guicursor = 'a:blinkon1,i-ci-ve:ver25-blinkon1'
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.wildmenu = true
o.wildignorecase = true
o.wildmode = 'longest,full'
o.wildoptions = 'pum'
o.pumblend = 0
o.pumheight = 15
o.mouse = 'a'
o.wrap = true
o.title = true
o.hidden = true
o.cmdheight = 1
o.scrolloff = 10
o.sidescrolloff = 8 -- Columns of context
o.shiftround = true -- Round indent
o.shiftwidth = 2
o.numberwidth = 3
o.number = false
o.relativenumber = false
o.showcmd = false
o.undofile = true
o.undodir = home..'/local/share/nvimundodir/'
o.autoread = true
o.autowrite = true
o.infercase = true
o.timeoutlen = 400
o.updatetime = 300
o.incsearch = true
o.showmatch = true
o.linebreak = true
o.showmode = false
o.swapfile = false
o.undolevels = 5000
o.modifiable = true
o.autoindent = true
o.smartindent = true
o.copyindent = true
o.ignorecase = true
o.cursorline = true
o.lazyredraw = false
o.splitright = true
o.splitbelow = true
o.breakindent = true
o.fixendofline = false
o.termguicolors = true
--o.splitkeep = 'screen'
o.signcolumn = 'yes'
o.colorcolumn = '99999'
o.encoding = 'utf-8'
o.listchars = 'eol:↲'
o.inccommand = 'split'
o.fillchars = {
  -- horiz = "━",
  -- horizup = "┻",
  -- horizdown = "┳",
  -- vert = "┃",
  -- vertleft = "┫",
  -- vertright = "┣",
  -- verthoriz = "╋",
  eob = ' ',
  foldopen = '',
  foldclose = '',
  diff = '╱',
}
o.showbreak = '   '
o.completeopt = 'menuone,noselect'
o.complete = '.,w,b,u,t,U,s,k,d,i'
o.keymap = 'russian-jcukenwin'
o.imsearch = 0
o.iminsert = 0
o.foldmethod = 'indent'
o.foldlevel = 20
o.pastetoggle = '<F3>'
o.laststatus = 3

-- o.formatoptions = "jcroqlnt" -- tcqj
o.grepprg = 'rg --vimgrep'
o.fileformat = 'unix'
o.binary = false
o.joinspaces = false -- No double spaces with join after a dot

o.clipboard:prepend { 'unnamedplus' }
o.shortmess:append 'sI'
o.whichwrap:append '<>hl'
