_G.__ = {}

__.read_all = function(dir)
	local dir_path = vim.fn.stdpath 'config' .. '/lua/' .. dir

	for _, file in ipairs(vim.fn.readdir(dir_path)) do
		if file ~= 'init.lua' then
			dofile(dir_path .. '/' .. file)
		end
	end
end

__.read_all(...)
