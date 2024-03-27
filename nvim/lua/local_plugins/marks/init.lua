local Manager = require 'local_plugins.marks.manager'

local manager
return {
    get_manager_instance = function()
        return manager
    end,
    setup = function(opts)
        manager = Manager:new(opts)
        manager:setup()
    end,
}
