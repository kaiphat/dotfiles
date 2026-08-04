# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   ENVS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'modules')
    ($env.HOME | path join 'secrets')
]

$env.EDITOR = 'nvim'
$env.PAGER = 'nvim -c "set nowrap" -R'
$env.NODE_OPTIONS = '--max-old-space-size=4096'
$env.SXHKD_SHELL = 'nu'
$env.SHELL = 'nu'
$env.JAVA_HOME = '/opt/homebrew/opt/openjdk@21'
$env.MANPAGER = 'nvim +Man! -c "set nowrap modifiable noreadonly buftype=nofile"'

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   PATHS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

$env.PATH ++= [
    /opt/homebrew/bin
    /usr/local/go/bin
    /usr/local/bin
    /usr/sbin
    $env.HOME + '/.config/carapace/bin'
    $env.HOME + '/go/bin'
    $env.HOME + '/.local/bin'
    $env.HOME + '/.cargo/bin'
    $env.HOME + '/.krew/bin'
    $env.HOME + '/Library/Python/3.9/bin'
    $env.JAVA_HOME + '/bin'
]
