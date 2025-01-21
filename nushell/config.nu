source ./themes/rose_pine_light.nu
source ./aliases.nu
source ./main.nu
source ./completer.nu
source ./keys.nu
source ~/.zoxide.nu
source ./run_tmux.nu

const g = {
    name: 1
    aaa: 3
}
def a [] {
    $g.name | print
    $g | get aaa -i | default false


}

use utils.nu
use commands.nu *
use git_commands.nu *
use change_theme.nu
use private.nu *
use open_links.nu
use fnm.nu
use prompt.nu
