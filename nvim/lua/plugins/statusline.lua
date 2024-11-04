local function get_colors()
	return {
		fg1 = vim.g.terminal_color_5,
		fg2 = vim.g.terminal_color_1,
		fg3 = vim.g.terminal_color_2,
		fg4 = vim.g.terminal_color_3,
	}
end

local get_macros_component = function(c, gap)
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
		enabled = function()
			return active_macros ~= nil
		end,
		provider = function()
			return active_macros:upper()
		end,
		hl = { fg = c.fg4 },
		left_sep = gap,
	}
end

local function get_marks_component(c, gap)
	return {
		icon = ' ',
		enabled = function()
			local manager = require('local_plugins.marks').get_manager_instance()
			return manager ~= nil and manager.active_mark_index ~= nil
		end,
		provider = function()
			return require('local_plugins.marks').get_manager_instance().active_mark_index:upper()
		end,
		hl = { fg = c.fg4 },
		right_sep = gap,
	}
end

local function get_components(c)
	local gap = { str = ' ', always_visible = true }

	return {
		gap = gap,
		marks = get_marks_component(c, gap),
		macros = get_macros_component(c, gap),
		path = {
			icon = '',
			provider = {
				name = 'file_info',
				opts = {
					type = 'relative',
					file_modified_icon = '',
				},
			},
			hl = { fg = c.fg1 },
			left_sep = gap,
		},
		git_branch = {
			icon = ' ',
			provider = 'git_branch',
			hl = { fg = c.fg2 },
			right_sep = gap,
		},
		position = {
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
			hl = { fg = c.fg1 },
		},
		lsp_errors = {
			icon = ' ',
			enabled = function()
				return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) ~= 0
			end,
			provider = function()
				return tostring(#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
			end,

			hl = { fg = c.fg2 },
			left_sep = gap,
		},
	}
end

return {
	'feline-nvim/feline.nvim',
	priority = 900,
	config = function()
		local colors = get_colors()
		local components = get_components(colors)

		require('feline').setup {
			theme = { bg = 'NONE', fg = 'NONE' },
			disable = {},
			components = {
				active = {
					{ components.path, components.macros, components.lsp_errors },
					{ components.marks, components.git_branch, components.position },
				},
				inactive = {
					{ components.path },
				},
			},
		}
	end,
}
