def main [pane?] {
    let path = "/tmp/tmux-current-pane";
    let width = term size | get columns | $in - 20
    tmux capture-pane -t $pane -p -J -S -10000 | save -f $path;
    tmux popup -h 40 -w $width -E $'nvim +Man! -c "set nowrap modifiable noreadonly buftype=nofile" "+normal G{}" ($path)'
}
