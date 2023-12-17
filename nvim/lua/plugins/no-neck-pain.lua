local M = {}

M.get_is_enabled = function()
	local width = get_terminal_width()

	if width > 250 then return true end

	return false
end

return {
	'shortcuts/no-neck-pain.nvim',
	enabled = false,
	event = 'BufReadPre',
	config = function()
		local nnp = require 'no-neck-pain'

		nnp.setup {
			autocmds = {
				enableOnVimEnter = M.get_is_enabled(),
			},

			width = 120,

			buffers = {
				backgroundColor = nil,

				scratchPad = {
					enabled = true,
					location = '~/documents/',
				},

				bo = {
					filetype = 'norg',
				},

				right = {
					enabled = true,
				},
			},
		}
	end,
}
