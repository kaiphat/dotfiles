# PATHS
let-env PATH = ($env.PATH | prepend '$snap_bin_path')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/emulator')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/tools')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/tools/bin')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/platform-tools')
let-env PATH = ($env.PATH | prepend '/opt/ReactNativeDebugger')
let-env PATH = ($env.PATH | prepend '/usr/local/go/bin')
let-env PATH = ($env.PATH | prepend '/usr/.local/bin')
let-env PATH = ($env.PATH | prepend "/home/kaiphat/.config/carapace/bin")
let-env PATH = ($env.PATH | prepend '$HOME/go/bin')
let-env PATH = ($env.PATH | prepend '$HOME/.cargo/bin')
let-env PATH = ($env.PATH | prepend '$HOME/.krew/bin')

# ENVS
let-env PROMPT_INDICATOR_VI_INSERT = ""
let-env PROMPT_INDICATOR_VI_NORMAL = ""
let-env nvm_default_version = 'v18.12.0'
let-env ANDROID_HOME = '$HOME/Android/Sdk'
let-env EDITOR = 'nvim'
let-env MANPAGER = 'most'
let-env PAGER = 'nvim -c "set nowrap" -R'
let-env TERMINAL = 'wezterm'
let-env NODE_OPTIONS = '--max-old-space-size=4096'
let-env SXHKD_SHELL = 'nu'

#
# STARTSHIP
#
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

#
# ZOXIDE
#
zoxide init nushell | save -f ~/.zoxide.nu

