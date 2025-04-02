local Provider = {}

Provider.__index = Provider

function Provider:new(opts)
	local hl_group = 'kaiphat_statusline_' .. opts.name

	local provider = setmetatable({
		value = '%#' .. hl_group .. '#' .. opts.value,
		update = opts.update or function() end,
	}, self)

	vim.api.nvim_set_hl(0, hl_group, { fg = opts.fg })

	provider.update()

	return provider
end

function Provider:on_update(fn)
	self.on_update = fn
end

return Provider
