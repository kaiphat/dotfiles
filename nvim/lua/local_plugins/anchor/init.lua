local Plugin = require 'local_plugins.anchor.Plugin'

local plugin = Plugin:new()

return {
	setup = function()
		plugin:setup()
	end,
	get_anchor_index = function()
		return plugin:get_anchor_index()
	end,
}
