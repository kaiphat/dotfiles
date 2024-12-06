export def main [path] {
    tmux send-keys -t 1 C-c;
    tmux respawn-pane -t 1 -k $'nu -e "SPEC=($path) make test-watch"';
}
