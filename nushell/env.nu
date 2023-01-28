# PATHS
let-env PATH = ($env.PATH | prepend '$snap_bin_path')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/emulator')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/tools')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/tools/bin')
let-env PATH = ($env.PATH | prepend '$ANDROID_HOME/platform-tools')
let-env PATH = ($env.PATH | prepend '/opt/ReactNativeDebugger')
let-env PATH = ($env.PATH | prepend '/usr/local/go/bin')
let-env PATH = ($env.PATH | prepend '$HOME/go/bin')
let-env PATH = ($env.PATH | prepend '/usr/.local/bin')
let-env PATH = ($env.PATH | prepend '$HOME/.cargo/bin')

# ENVS
let-env nvm_default_version = 'v18.12.0'
let-env ANDROID_HOME = '$HOME/Android/Sdk'
let-env EDITOR = 'nvim'
let-env MANPAGER = 'most'
let-env PAGER = 'nvim -c "set nowrap" -R'
let-env TERMINAL = 'wezterm'
let-env NODE_OPTIONS = '--max-old-space-size=4096'
let-env LS_COLORS = (vivid generate nord | str trim)


# STARSHIP
# mkdir ~/.cache/starship
# starship init nu | save ~/.cache/starship/init.nu

# ZOXIDE
zoxide init nushell | save ~/.zoxide.nu

