local module = {}
local config = {}

module.set = function(overrides)
	for key, value in pairs(overrides) do
		config[key] = value
	end
end

module.get = function()
	return config
end

return module
