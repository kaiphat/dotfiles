local o = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ','
g.markdown_folding = 1

local TAB_SIZE = 4

-- enable new messages ui
require('vim._core.ui2').enable {
	msg = {
		targets = 'cmd',
	},
}

o.winborder = 'rounded'
o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25'

-- has problem with nushell. Doesn't support < operator
o.shell = 'bash'
o.jumpoptions = 'stack'
o.smoothscroll = true
o.selection = 'old'
o.tabstop = TAB_SIZE
o.softtabstop = TAB_SIZE
o.shiftwidth = TAB_SIZE
o.expandtab = true
o.fileencoding = 'utf-8'
o.wildmenu = true
o.wildignorecase = true
o.wildmode = 'longest,full'
o.winminwidth = 5
o.wildoptions = 'pum'
o.pumblend = 0
o.pumheight = 15
o.mouse = 'a'
o.wrap = true
o.title = true
o.hidden = true
o.cmdheight = 0
o.scrolloff = 10
o.sidescrolloff = 8 -- Columns of context
o.shiftround = true -- Round indent
o.numberwidth = 3
o.number = false
o.relativenumber = false
o.showcmd = false
o.showmode = false
o.undofile = true
o.writebackup = false
o.backup = false
o.history = 1000
o.autoread = true
o.autowrite = true
o.infercase = true
o.timeoutlen = 1000
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
o.copyindent = false
o.ignorecase = true
o.smartcase = true
o.ruler = false
o.cursorline = false
o.cursorcolumn = false
o.lazyredraw = false
o.ttyfast = true
o.splitright = true
o.splitbelow = true
o.breakindent = true
o.fixendofline = false
o.termguicolors = true
o.splitkeep = 'screen'
o.signcolumn = 'yes'
o.colorcolumn = '99999'
o.encoding = 'utf-8'
o.list = false
o.listchars:append {
	-- eol ='↲',
	trail = '·',
	nbsp = '␣',
}
o.fillchars = {
	-- horiz = "━",
	-- horizup = "┻",
	-- horizdown = "┳",
	-- vert = '┃',
	-- vertleft = "┫",
	-- vertright = "┣",
	-- verthoriz = "╋",
	eob = ' ',
	fold = ' ',
	foldopen = '',
	foldclose = '',
	diff = '╱',
	-- not working ???!
	lastline = '·',
	stl = ' ',
	stlnc = ' ',
}
o.diffopt = {
	'internal',
	'filler',
	'closeoff',
	'context:12',
	'algorithm:histogram',
	'linematch:200',
	'indent-heuristic',
}
o.inccommand = 'split'
o.showbreak = '  ↳ '
o.completeopt = 'menuone,preview,noselect'
o.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,'
	.. 'фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
o.imsearch = 0
o.iminsert = 0
o.laststatus = 3
o.grepprg = 'rg --vimgrep'
o.fileformat = 'unix'
o.fileformats = { 'unix', 'dos' }
o.formatoptions = 'jcroqlnt'
o.binary = false
o.joinspaces = false -- No double spaces with join after a dot
o.clipboard:prepend { 'unnamedplus' }
o.spelllang = { 'en' }
o.shortmess:append 'sIWcC'
o.whichwrap:append '<>hl'
o.conceallevel = 2

-- o.foldmethod = 'expr'
-- o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldtext = 'v:lua.get_foldtext()'
o.foldcolumn = '0'
o.foldminlines = 3
o.foldnestmax = 5
o.foldlevel = 99
o.foldlevelstart = 99
o.foldopen = 'hor,mark,percent,quickfix,search,tag,undo'

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	group = kaiphat.utils.create_augroup 'lsp_fold',
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client and client:supports_method 'textDocument/foldingRange' then
-- 			local win = vim.api.nvim_get_current_win()
-- 			vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
-- 		end
-- 	end,
-- })

_G.get_foldtext = function()
	local last_line = table.concat(vim.fn.getbufline(vim.api.nvim_get_current_buf(), vim.v.foldend))
	local first_line = table.concat(vim.fn.getbufline(vim.api.nvim_get_current_buf(), vim.v.foldstart))

	local tab_width = vim.o.tabstop
	local space_before_text = first_line:match('^%s*'):gsub('\t', string.rep(' ', tab_width))

	return space_before_text .. ' ' .. vim.trim(first_line) .. ' ... ' .. vim.trim(last_line)
end
