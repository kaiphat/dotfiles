return {
	dir = './',
	event = 'BufReadPre',
	config = function()
		local marks = require 'local_plugins.marks'
		marks.setup {}
	end,
}
