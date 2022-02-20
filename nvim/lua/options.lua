local o = vim.opt

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
o.cindent          = true
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
o.ignorecase       = true
o.cursorline       = true
o.lazyredraw       = true
o.splitright       = true
o.splitbelow       = true
o.smartindent      = true
o.breakindent      = true
o.fixendofline     = false
o.termguicolors    = true
o.signcolumn       = 'yes'
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
o.foldmethod = 'indent'
o.foldlevel = 20
o.pastetoggle = '<F3>'

o.fileformat       = 'unix'
o.binary           = false

o.shortmess:append("sI")
o.whichwrap:append("<>hl")

vim.cmd [[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]]

local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
