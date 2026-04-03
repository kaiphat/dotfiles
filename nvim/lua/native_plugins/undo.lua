vim.cmd 'packadd nvim.undotree'

vim.api.nvim_create_user_command('Undo', function()
	require('undotree').open()
end, {})
