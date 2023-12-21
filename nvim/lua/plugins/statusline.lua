local colors = {
    fg1 = '#a3b8ef',
    fg2 = '#EBCB8B',
	fg3 = '#7eca9c',
    fg4 = '#ff75a0',
}

local gap = { str = ' ', always_visible = true }

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
	right_sep = gap,
}

local get_macros_component = function ()
    local active_macros

    local group = vim.api.nvim_create_augroup('recording_group', {})
    vim.api.nvim_create_autocmd('RecordingEnter', {
        group = group,
        callback = function()
            active_macros = vim.fn.reg_recording()
        end,
    })
    vim.api.nvim_create_autocmd('RecordingLeave', {
        group = group,
        callback = function()
            active_macros = nil
        end,
    })

    return {
        icon = '󰛡 ',
        enabled = function() return active_macros ~= nil end,
        provider = function() return active_macros:upper() end,
        hl = { fg = colors.fg4 },
        right_sep = gap,
    }
end

local git_branch = {
	icon = ' ',
	provider = 'git_branch',
	hl = { fg = colors.fg2 },
	left_sep = gap,
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
	left_sep = gap,
}

return {
	'feline-nvim/feline.nvim',
	config = function()
		require('feline').setup {
			theme = {
				bg = 'NONE',
			},
			disable = {},
			components = {
				active = {
					{ path, get_macros_component() },
					{ git_branch, position },
				},
			},
		}
	end,
}
