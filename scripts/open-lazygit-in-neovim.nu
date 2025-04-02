def main [filename line?] {
    let session = tmux display-message -p '#S'
    let window = tmux display-message -p '#I'
    let pane = tmux display-message -p '#{pane_pid}'

    let base_name = $"/tmp/nvim-($session)-($window)";
    let current_pane_name = $"($base_name)-($pane)";
    let cmd = $"<cmd>lua kaiphat.scripts.lazygit_open_file\('($filename)', '($line)'\)<CR>"
    let current_nvim_processes = ps -l | where name =~ 'nvim'

    if not ($current_nvim_processes | where command =~ $current_pane_name | is-empty) {
        nvim --server $current_pane_name --remote-send $cmd
    } else {
        let processes_in_window = $current_nvim_processes | where command =~ $"/tmp/nvim-($session)-($window)-"

        if not ($processes_in_window | is-empty) { 
            let listen = $processes_in_window | first | get command | parse "{cmd} --listen {listen}" | get listen | first

            nvim --server $listen --remote-send $cmd
        } else {
            nvim $filename
        }
    }
}
