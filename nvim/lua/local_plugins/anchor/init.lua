local Plugin = require 'local_plugins.anchor.Plugin'

local plugin
local function get_plugin()
	if not plugin then
		plugin = Plugin:new()
	end
	return plugin
end

return {
	setup = function()
		get_plugin():setup()
	end,
	get_anchor_index = function()
		return get_plugin():get_anchor_index()
	end,
}
