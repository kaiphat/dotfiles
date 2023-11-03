local M = {}

local C = {
	dark_blue = '#404060',
	cyan = '#a3b8ef',
	light_blue = '#9398cf',
	green = '#7eca9c',
	yellow = '#EBCB8B',
	red = '#e06c75',
	pink = '#ff75a0',
}

M.get_position = function()
	local function add_zeroes(number)
		if number < 10 then
			return '00' .. number
		elseif number < 100 then
			return '0' .. number
		end
		return number
	end

	local current_line = add_zeroes(vim.fn.line '.')
	local total_line = add_zeroes(vim.fn.line '$')

	return current_line .. ':' .. total_line
end

M.build_gap = function(bg)
	return {
		str = ' ',
		hl = {
			bg = bg,
		},
	}
end

M.path = {
	icon = '',
	provider = {
		name = 'file_info',
		opts = {
			type = 'relative',
			file_modified_icon = '',
		},
	},
	hl = {
		fg = C.dark_blue,
		bg = C.cyan,
	},
	left_sep = M.build_gap(C.cyan),
	right_sep = {
		M.build_gap(C.cyan),
		{
			str = 'right_filled',
			hl = function()
				local bg = nil

				if require('noice').api.statusline.mode.has() then bg = C.yellow end

				return {
					fg = C.cyan,
					bg = bg,
				}
			end,
		},
	},
}

M.macros = {
	enabled = require('noice').api.statusline.mode.has,
	icon = '',
	provider = function() return require('noice').api.statusline.mode.get() end,
	hl = {
		bg = C.yellow,
		fg = C.dark_blue,
	},
	left_sep = M.build_gap(C.yellow),
	right_sep = {
		M.build_gap(C.yellow),
		{
			str = 'right_filled',
			hl = {
				fg = C.yellow,
			},
		},
	},
}

M.git_diff_added = {
	icon = '+',
	provider = 'git_diff_added',
	hl = {
		fg = C.green,
	},
	left_sep = M.build_gap(),
}

M.git_diff_changed = {
	icon = '~',
	provider = 'git_diff_changed',
	hl = {
		fg = C.yellow,
	},
	left_sep = M.build_gap(),
}

M.git_diff_removed = {
	icon = '-',
	provider = 'git_diff_removed',
	hl = {
		fg = C.red,
	},
	left_sep = M.build_gap(),
}

M.diagnostic_errors = {
	icon = 'x',
	provider = 'diagnostic_errors',
	hl = {
		fg = C.pink,
	},
	left_sep = M.build_gap(),
}

M.git_branch = {
	icon = ' ',
	provider = 'git_branch',
	hl = {
		fg = C.yellow,
		bg = C.dark_blue,
	},
	right_sep = M.build_gap(C.dark_blue),
	left_sep = {
		{
			str = 'left_filled',
			hl = {
				fg = C.dark_blue,
			},
		},
		M.build_gap(C.dark_blue),
	},
}

M.position = {
	icon = ' ',
	provider = M.get_position,
	hl = {
		fg = C.dark_blue,
		bg = C.light_blue,
	},
	right_sep = M.build_gap(C.light_blue),
	left_sep = {
		{
			str = 'left_filled',
			hl = function()
				if require('feline.providers.git').git_info_exists() then
					return {
						bg = C.dark_blue,
						fg = C.light_blue,
					}
				else
					return {
						fg = C.light_blue,
					}
				end
			end,
		},
		M.build_gap(C.light_blue),
	},
}

M.left_components = {
	M.path,
	M.macros,
	M.git_diff_added,
	M.git_diff_removed,
	M.git_diff_changed,
	M.diagnostic_errors,
}

M.right_components = {
	M.git_branch,
	M.position,
}

return {
	'feline-nvim/feline.nvim',
	config = function()
		local feline = require 'feline'

		feline.setup {
			theme = {
				bg = 'NONE',
			},
			disable = {
				filetypes = {
					'NvimTree',
					'packer',
					'Telescope',
				},
			},
			components = {
				active = {
					M.left_components,
					M.right_components,
				},
			},
		}
	end,
}
