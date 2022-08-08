vim.g.catppuccin_flavour = 'frappe' -- latte, frappe, macchiato, mocha

local catppuccin = load('catppuccin')
if not catppuccin then return end

catppuccin.setup {

}

vim.cmd 'colorscheme catppuccin'
