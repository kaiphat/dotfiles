return function(filename, line_number)
	line_number = tonumber(line_number) or 1

	vim.api.nvim_feedkeys('q', 'n', true)

	vim.schedule(function()
		vim.cmd 'silent! vs'
		vim.api.nvim_command('edit +' .. line_number .. ' ' .. filename)
	end)
end
