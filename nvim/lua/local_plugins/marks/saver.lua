local Path = require 'plenary.path'

local function save_to_file(path, data) Path:new(path):write(vim.json.encode(data or {}), 'w') end

local function read_from_file(path)
	path = Path:new(path)

	local exists = path:exists()

	if not exists then save_to_file(path, {}) end

	local out_data = path:read()

	if not out_data or out_data == '' then
		save_to_file(path, {})
		out_data = path:read()
	end

	return vim.json.decode(out_data)
end

return {
	save_to_file = save_to_file,
	read_from_file = read_from_file,
}
