---@param group string
local _ = function(group)
	---@param opts vim.api.keyset.highlight,
	return function(opts)
		vim.api.nvim_set_hl(0, group, opts)
	end
end

local visual = '#d9d9ee'
local line = '#ccccdd'
local text = '#993333'
local keyword = '#115577'

local red = '#993333'

_ 'Normal' { bg = '' }
_ 'NormalFloat' { bg = '' }
_ 'Pmenu' { bg = '' }
_ 'ColorColumn' { bg = '' }
_ 'PmenuSel' { bg = visual }
_ 'Visual' { bg = visual }
_ 'CurSearch' { bg = visual }
_ 'String' { fg = text }
_ 'Keyword' { fg = keyword }

_ 'MiniCursorword' { bg = visual, underline = false }
_ 'MiniCursorwordCurrent' { bg = visual, underline = false }

_ 'DiagnosticWarn' { link = 'DiagnosticError' }
_ 'DiagnosticUnderlineOk' { underline = false, undercurl = true }
_ 'DiagnosticUnderlineHint' { underline = false, undercurl = true }
_ 'DiagnosticUnderlineInfo' { underline = false, undercurl = true }
_ 'DiagnosticUnderlineWarn' { underline = false, undercurl = true }
_ 'DiagnosticUnderlineError' { fg = red, underline = false, undercurl = true }

_ 'WinSeparator' { fg = line }
_ 'IndentBlanklineChar' { fg = line }
_ 'IndentBlanklineContextChar' { fg = line }
