if ($env | get -i TMUX | is-empty) {
    let output = tmux list-sessions | complete

    if $output.exit_code == 1 {
        tn main
        return
    }

    let sessions = $output.stdout | lines | split column ':' session

    if ($sessions | length) == 0 {
        tn main
        return
    }

    let main_session = $sessions | where session == 'main'

    if ($main_session | length) == 0 {
        tn main
        return
    }

    ta main
}
