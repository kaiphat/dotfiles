local o = vim.opt
local g = vim.g

g.mapleader          = ' '
g.do_filetype_lua    = 1

o.updatetime       = 500
o.tabstop          = 2
o.softtabstop      = 2
o.expandtab        = true
o.wildmenu         = true
o.wildignorecase   = true
o.wildmode         = 'longest,full'
o.wildoptions      = 'pum'
o.pumblend         = 5
o.pumheight        = 15
o.mouse            = 'a'
o.wrap             = true
o.title            = true
o.hidden           = true
o.cmdheight        = 1
o.scrolloff        = 10
o.shiftwidth       = 2
o.numberwidth      = 3
o.number           = false
o.relativenumber   = false
o.showcmd          = false
o.undofile         = true
o.autoread         = true
o.infercase        = true
o.timeoutlen       = 400
o.updatetime       = 250
o.incsearch        = true
o.showmatch        = true
o.linebreak        = true
o.showmode         = false
o.swapfile         = false
o.undolevels       = 5000
o.modifiable       = true
o.autoindent       = true
o.smartindent      = true
o.copyindent       = true
o.ignorecase       = true
o.cursorline       = true
o.lazyredraw       = true
o.splitright       = true
o.splitbelow       = true
o.breakindent      = true
o.fixendofline     = false
o.termguicolors    = true
o.signcolumn       = 'no'
-- o.signcolumn       = 'yes'
o.colorcolumn      = '99999'
vim.wo.colorcolumn = '99999'
o.encoding         = 'utf-8'
o.listchars        = 'eol:↲'
o.inccommand       = 'split'
o.clipboard        = 'unnamedplus'
o.fillchars        = 'vert:│,eob: '
o.showbreak        = '   '
o.completeopt      = 'menuone,noselect'
o.complete         = '.,w,b,u,t,U,s,k,d,i'
o.keymap           = 'russian-jcukenwin'
o.imsearch         = 0
o.iminsert         = 0
o.foldmethod       = 'indent'
o.foldlevel        = 20
o.pastetoggle      = '<F3>'
o.laststatus       = 3

o.fileformat       = 'unix'
o.binary           = false

o.shortmess:append("sI")
o.whichwrap:append("<>hl")

local disabled_built_ins = {
  "2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"fzf"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

