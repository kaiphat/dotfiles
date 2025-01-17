return {
	'folke/snacks.nvim',
	event = 'VeryLazy',
	enabled = true,
	keys = {
		-- lazygit
		{
			'<leader>lg',
			function()
				Snacks.lazygit()
			end,
		},
		{
			'<leader>gf',
			function()
				Snacks.lazygit.log_file()
			end,
		},

		-- picker
		-- {
		-- 	'<leader>fj',
		-- 	function()
		-- 		Snacks.picker.files {
		-- 			format = 'file',
		-- 		}
		-- 	end,
		-- },
		-- {
		-- 	'<leader>dj',
		-- 	function()
		-- 		Snacks.picker.files {
		-- 			hidden = true,
		-- 		}
		-- 	end,
		-- },
	},
	opts = {
		lazygit = {
			win = {
				style = 'lazygit',
			},
			config = {
				os = nil,
			},
		},

		-- picker = {
		-- 	ui_select = true,
		-- 	formatters = {
		-- 		file = {
		-- 			filename_first = true, -- display filename before the file path
		-- 		},
		-- 	},
		-- },
		--
		-- indent = {
		-- 	char = kaiphat.constants.icons.VERTICAL_LINE_5,
		-- 	indent = {
		-- 		enabled = true,
		-- 		char = kaiphat.constants.icons.VERTICAL_LINE_5,
		-- 	},
		-- },
	},
	config = function()
		-- Snacks.toggle.inlay_hints():map '<leader>uh'
		-- Snacks.indent.enable()
	end,
}
