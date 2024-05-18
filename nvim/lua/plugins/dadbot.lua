return {
	'kristijanhusak/vim-dadbod-ui',
	dependencies = {
		{ 'tpope/vim-dadbod', lazy = true },
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1

		vim.g.dbs = {
			preprod_local = 'postgresql://postgres:test-postgres-pass@localhost:15433/redecor',
		}
	end,
}
