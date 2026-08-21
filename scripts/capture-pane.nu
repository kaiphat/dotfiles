def main [width pane?] {
    let path = "/tmp/tmux-current-pane";
    tmux capture-pane -t $pane -p -J -S -10000 | save -f $path;
    tmux popup -h 40 -w ($width - 30) -E $'nvim_pager ($path)'
}
