local awful = require 'awful'
local awesome = awesome

awesome.connect_signal('startup', function() awful.util.spawn 'bash -c "~/dotfiles/scripts/autostart.sh"' end)
