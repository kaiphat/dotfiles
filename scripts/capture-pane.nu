def main [pane?] {
    let path = "/tmp/tmux-current-pane";
    tmux capture-pane -t $pane -p -J -S -10000 | save -f $path;
    tmux popup -h 60 -w 200 -E $'nvim +Man! -c "set nowrap modifiable noreadonly buftype=nofile" "+normal G{}" ($path)'
}
