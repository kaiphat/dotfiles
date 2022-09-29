local awful = require 'awful'

awful.spawn('picom --experimental-backends', false)
awful.spawn('bash -c "/home/ipunko/.config/awesome/autostart/autostart_script.sh"')
