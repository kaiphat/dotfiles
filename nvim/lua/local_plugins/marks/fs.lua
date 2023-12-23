local Path = require 'plenary.path'

local Fs = {}

Fs.__index = Fs

function Fs:new(path)
	return setmetatable({
		path = Path:new(path),
	}, self)
end

function Fs:write(data)
	self.path:write(vim.json.encode(data or {}), 'w')
end

function Fs:read()
	local exists = self.path:exists()

	if not exists then
		self:write {}
	end

	local out_data = self.path:read()

	if not out_data or out_data == '' then
		self:write {}
		out_data = self.path:read()
	end

	return vim.json.decode(out_data)
end

return Fs
