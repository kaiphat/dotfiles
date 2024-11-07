export def gc [message] {
    let branch = (git rev-parse --abbrev-ref HEAD)
    let ticket = ($branch | awk -F/ '{print $NF}')
    let message = ($message | awk '{print toupper(substr($0, 1, 1)) substr($0, 2)}')

    git add -A
    git commit -m $"($ticket): ($message)"
}
