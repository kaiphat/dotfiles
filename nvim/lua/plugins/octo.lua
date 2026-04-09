__.add_plugin {
	'pwntester/octo.nvim',
	cmds = { 'Octo' },
	deps = {
		'plenary',
		'snacks',
		'nvim-web-devicons',
	},
	opts = {
		use_local_fs = true,
		picker = 'snacks',
	},
}
