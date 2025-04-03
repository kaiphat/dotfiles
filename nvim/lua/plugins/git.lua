return {
	{
		'sindrets/diffview.nvim',
		cmd = { 'DiffviewOpen' },
		config = function()
			require('diffview').setup {
				hooks = {
					diff_buf_read = function(bufnr)
						vim.api.nvim_create_autocmd({ 'VimResized', 'WinEnter' }, {
							group = kaiphat.utils.create_augroup 'resize_pane',
							buffer = bufnr,
							callback = function(event)
								vim.cmd 'wincmd ='
							end,
						})
						vim.opt_local.wrap = true
					end,
					view_opened = function(view)
						-- vim.cmd ':WindowsDisableAutowidth'
					end,
				},
			}
		end,
	},
}
