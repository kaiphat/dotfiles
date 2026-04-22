local active_macros
local progress_status_title
local progress_status_client

local hl = function(group)
	return '%#' .. group .. '#'
end

local dhl = hl 'StatusLine'
local branch_icon = hl 'StatusLineBranch' .. __.icons.BRANCH .. dhl
local honey_icon = hl 'StatusLineFileChanged' .. __.icons.HONEY .. dhl
local error_icon = hl 'StatusLineLspError' .. __.icons.CIRCLE_WITH_CROSS .. dhl
local flag_icon = hl 'StatusLineFlag' .. __.icons.FLAG .. dhl
local modified_icon = ' ' .. hl 'StatusLineFileChanged' .. __.icons.LIGHTNING

local statusline_groups = {
	StatusLineFileChanged = { link = 'DiagnosticWarn' },
	StatusLineLspError = { link = 'DiagnosticError' },
	StatusLineFlag = { link = '@operator' },
	StatusLineBranch = { link = 'GitSignsChange' },
}

local function set_hl_groups()
	for group, opts in pairs(statusline_groups) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   COMPONENTS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local function git()
	local head = vim.b.gitsigns_head

	if not head or head == '' then
		return
	end

	return branch_icon .. ' ' .. head
end

local function macros()
	if not active_macros then
		return
	end

	return honey_icon .. ' ' .. active_macros
end

local function lsp_progress()
	if not progress_status_client or not progress_status_title then
		return
	end

	return hl 'StatusLineLspError'
		.. __.icons.CIRCLE_SMALL
		.. ' '
		.. progress_status_client
		.. ': '
		.. progress_status_title
end

local function diagnostic()
	local errors_amount = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

	if errors_amount < 1 then
		return
	end

	return error_icon .. ' ' .. tostring(errors_amount)
end

local function file()
	local path = __.utils.get_relative_path()
	local modified = vim.bo.modified and modified_icon or ''
	return path .. hl 'StatusLineFileChanged' .. modified
end

local function position()
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

	return __.icons.CIRCLE_SMALL .. ' ' .. current_line .. ':' .. total_line
end

local function anchor()
	local index = require('local_plugins.anchor').get_anchor_index()

	if not index then
		return
	end

	return flag_icon .. ' ' .. index:upper()
end

local function render()
	-- local win_is_active = tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win()
	--
	-- if not win_is_active then
	-- 	local file_component = file()
	-- 	return file_component and ' ' .. file_component or ''
	-- end

	local components = {
		file(),
		macros(),
		diagnostic(),
		lsp_progress(),
		'%=',
		anchor(),
		git(),
		position(),
	}

	return table.concat(vim.iter(components):flatten():totable(), dhl .. ' ')
end

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   COMPONENTS END   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local function setup()
	vim.api.nvim_create_autocmd('LspProgress', {
		group = __.utils.create_augroup 'statusline_lsp_progress',
		-- pattern = { 'begin', 'end' },
		callback = function(args)
			if not args.data then
				return
			end

			progress_status_client = vim.lsp.get_client_by_id(args.data.client_id).name
			progress_status_title = args.data.params.value.title

			if args.data.params.value.kind == 'end' then
				progress_status_title = nil
				progress_status_client = nil

				-- Wait a bit before clearing the status.
				vim.defer_fn(function()
					vim.api.nvim__redraw { statusline = true }
				end, 2000)
			else
				vim.api.nvim__redraw { statusline = true }
			end
		end,
	})

	vim.api.nvim_create_autocmd('ColorScheme', {
		group = __.utils.create_augroup 'statusline_colors',
		callback = set_hl_groups,
	})

	vim.api.nvim_create_autocmd('User', {
		pattern = 'GitSignsUpdate',
		group = __.utils.create_augroup 'statusline_gitsigns',
		command = 'redrawstatus',
	})

	local group = __.utils.create_augroup 'macros'

	vim.api.nvim_create_autocmd('RecordingEnter', {
		group = group,
		callback = function()
			active_macros = vim.fn.reg_recording():upper()
		end,
	})

	vim.api.nvim_create_autocmd('RecordingLeave', {
		group = group,
		callback = function()
			active_macros = nil
		end,
	})

	vim.opt.statusline = '%{%v:lua.require\'local_plugins.statusline\'.render()%}'

	set_hl_groups()

	render()
end

return {
	render = render,
	setup = setup,
}
