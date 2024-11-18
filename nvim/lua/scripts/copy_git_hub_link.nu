export def main [path row_index] {
    use ~/dotfiles/nushell/modules/utils.nu
    let remote = utils get_git_remote_root
    let branch = git rev-parse --abbrev-ref HEAD
    let git_root = git rev-parse --show-toplevel
    let relative_path = $path | path relative-to $git_root
    $'https://github.com/($remote)/blob/($branch)/($relative_path)#L($row_index)' | pbcopy
}
