set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man! -c "set nowrap modifiable noreadonly buftype=nofile"'
set -gx PAGER 'less'
set -gx BAT_PAGER 'less'
set -gx LUA_DIR /usr/bin/lua
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient_21_8
set -gx XDG_CONFIG_HOME ~/.config
set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk@17/include"

set -U fish_greeting
set -U ignoreeof true
set -U SXHKD_SHELL sh
set -U TERMINFO /usr/share/terminfo
set -U nvm_default_version v20.16.0
# set -x JAVA_HOME (/usr/libexec/java_home -v 1.7)

fish_add_path -aP $snap_bin_path
fish_add_path -aP /opt/homebrew/bin
fish_add_path -aP $ANDROID_HOME/emulator
fish_add_path -aP $ANDROID_HOME/tools
fish_add_path -aP $ANDROID_HOME/tools/bin
fish_add_path -aP $ANDROID_HOME/platform-tools
fish_add_path -aP /opt/ReactNativeDebugger
fish_add_path -aP /usr/local/go/bin
fish_add_path -aP /usr/.local/bin
fish_add_path -aP /usr/bin/lua
fish_add_path -aP /usr/bin/i3
fish_add_path -aP /usr/bin/i3bar
fish_add_path -aP $HOME/go/bin
fish_add_path -aP $HOME/.cargo/bin
fish_add_path -aP $HOME/.krew/bin
fish_add_path -aP $HOME/.local/share/bob/nvim-bin
fish_add_path -aP $HOME/.local/bin/razer-cli
fish_add_path -aP $HOME/.yarn/bin
fish_add_path -aP $HOME/.local/bin
fish_add_path -aP $HOME/.local/share/nvim/mason/bin/
fish_add_path -aP /opt/homebrew/opt/openjdk@17/bin

bind \cd delete-char
bind \cw backward-kill-word

