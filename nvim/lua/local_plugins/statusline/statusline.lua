local Provider = require 'local_plugins.statusline.provider'

local Statusline = {}

Statusline.__index = Statusline

function Statusline:new(opts)
	vim.g.qf_disable_statusline = true

	return setmetatable({
		providers = {},
	}, self)
end

function Statusline:get()
	local statusline = ''

	for _, provider in ipairs(self.providers) do
		provider.update()
		statusline = statusline .. provider.value
	end

    return statusline
end

function Statusline:update()
	vim.o.statusline = '%{%v:lua.kaiphat.generate_statusline()%}'
end

function Statusline:add_provider(provider)
	provider:on_update(function()
		Statusline:update()
	end)

	table.insert(self.providers, provider)
end

return {
	setup = function(opts)
		local statusline = Statusline:new()

		statusline:add_provider(Provider:new {
			name = 'path',
			value = '%f',
			fg = '#00ffff',
		})

		kaiphat.generate_statusline = function()
			return statusline:get()
		end

		statusline:update()
	end,
}
