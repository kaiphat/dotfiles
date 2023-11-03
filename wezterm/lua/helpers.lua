_G.merge = function(...)
	local args = { ... }
	local result = {}

	for _, t in ipairs(args) do
		for key, value in pairs(t) do
			result[key] = value
		end
	end

	return result
end
