if ($env | get -i TMUX | is-empty) {
    let sessions = tmux list-sessions | lines | split column ':' session

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
