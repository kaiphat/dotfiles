local colors = {
    fg1 = '#a3b8ef',
    fg2 = '#EBCB8B',
	dark_blue = '#404060',
	light_blue = '#9398cf',
	green = '#7eca9c',
	red = '#e06c75',
	pink = '#ff75a0',
}

local gap = { icon = { str = ' ', always_visible = true } }

local path = {
	icon = '',
	provider = {
		name = 'file_info',
		opts = {
			type = 'relative',
			file_modified_icon = '',
		},
	},
	hl = { fg = colors.fg1 },
}

local macros = {
	enabled = require('noice').api.statusline.mode.has,
	icon = '',
	provider = function() return require('noice').api.statusline.mode.get() end,
	hl = { fg = colors.fg2 },
}

local git_branch = {
	icon = ' ',
	provider = 'git_branch',
	hl = { fg = colors.fg2 },
}

local position = {
	icon = ' ',
	provider = function()
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
	end,
	hl = { fg = colors.fg1 },
}

return {
	'feline-nvim/feline.nvim',
	dependencies = { 'folke/noice.nvim' },
	enabled = true,
	config = function()
		require('feline').setup {
			theme = {
				bg = 'NONE',
			},
			disable = {},
			components = {
				active = {
					{ gap, path, gap, macros },
					{ git_branch, gap, position, gap },
				},
			},
		}
	end,
}
