vim.o.background = 'light'

vim.cmd 'colorscheme default'

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

hl('NormalFloat', { bg = 'NONE' })
hl('MiniCursorword', { bg = 'NvimLightGrey3' })
hl('Visual', { bg = 'NvimLightGrey3' })
hl('DiagnosticUnderlineWarn', { link = 'DiagnosticUnderlineWarn', undercurl = true })
hl('DiagnosticUnderlineInfo', { link = 'DiagnosticUnderlineInfo', undercurl = true })
hl('DiagnosticUnderlineHint', { link = 'DiagnosticUnderlineHint', undercurl = true })
hl('DiagnosticUnderlineError', { link = 'DiagnosticUnderlineError', undercurl = true })

return {}
