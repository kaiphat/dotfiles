_G.__ = {}

__.read_all = function(dir)
	for _, file in ipairs(vim.api.nvim_get_runtime_file('lua/' .. dir .. '/*.lua', true)) do
		local filename = vim.fn.fnamemodify(file, ':t:r')

		if filename ~= 'init' then
			require(dir .. '.' .. filename)
		end
	end
end

__.read_all(...)
