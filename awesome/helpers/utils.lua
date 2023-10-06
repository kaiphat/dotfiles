local awful = require 'awful'

_G.spawn = function(cmd)
	return function() awful.spawn(cmd) end
end

_G.spawn_script = function(path)
	return function() awful.spawn('bash -c "' .. path .. '"') end
end
