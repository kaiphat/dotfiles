local Config = {}

Config.__index = Config

function Config:new(opts)
	return setmetatable({
		wezterm_config = {},
	}, self)
end

function Config:add(table)
	for key, value in pairs(table) do
		self.wezterm_config[key] = value
	end
end

function Config:set_keys(table)
	self.wezterm_config.keys = table
end

function Config:set_mouse_bindings(table)
	self.wezterm_config.mouse_bindings = table
end

function Config:set_window_paddings(table)
	self.wezterm_config.window_padding = table
end

function Config:to_wezterm_config()
	return self.wezterm_config
end

return Config
