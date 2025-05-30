export def main [path] {
    let container_name = docker ps -a 
        | from ssv -a 
        | where NAMES =~ 'reservecool-test'
        | get NAMES
        | first

    docker exec $container_name sh -c "ps aux | grep mocha | grep -v grep | awk '{print \$1}' | xargs kill -SIGINT" | complete
    tmux respawn-pane -t 1 -k $'nu -e "SPEC=($path) make test-watch"';
}
