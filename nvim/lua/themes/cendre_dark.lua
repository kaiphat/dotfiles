__.add_plugin {
	'Aejkatappaja/cendre',
	name = 'cendre',
	is_instant = true,
	load = function(_)
		_.setup {
			background = 'medium', -- "hard" | "medium" | "soft"
			italic = false,
		}

		vim.cmd.colorscheme 'cendre'
	end,
}
