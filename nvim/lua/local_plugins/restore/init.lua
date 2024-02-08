local restore_service = require 'local_plugins.restore.restore_service'

return {
	setup = function()
		restore_service:setup()
	end,
	restore = function()
		restore_service:restore()
    end
}
