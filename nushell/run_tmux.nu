if ($env | get -o TMUX | is-empty) {
    try {
        tmux list-sessions 
        | lines 
        | split column ':' session
        | where session == 'main'
        | if ($in | is-empty) { ignore; tn main } else { ignore; ta main }
    } catch {
        tn main
    }
}
