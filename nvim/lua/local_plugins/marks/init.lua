local manager = require 'local_plugins.marks.manager'

return {
    manager = manager,
    setup = function(opts)
        manager:setup(opts)
    end,
}
