def main [w] {
    let a = tmux list-panes -a -F '#{window_active} #{pane_active} #{pane_current_path}'
    | split row (char newline)
    | parse "{wa} {pa} {path}"
    | where $in.pa == '1'
    | update path { str replace $env.HOME '~' }

    let paths_width = $a | each { get path | str length } | math sum
    let width = $paths_width + (($a | length) - 1) * 3
    let space = '' | fill -c (char space) -w (($w - $width) / 2 | math floor)
    let paths = $a
    | each {|$it| if $it.wa == '1' { $'#[fg=red]($it.path)' } else { $'#[default]($it.path)' } }
    | str join ' ◦ '

    $"($space)($paths)"
}
