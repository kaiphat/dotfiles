export def get_git_remote_root [] {
    let url = (git remote get-url origin)
    let repository = (echo $url | awk -F/ '{print $NF}' | awk -F. '{print $1}')
    let namespace = (echo $url | awk -F: '{print $2}' | awk -F/ '{print $1}')
    $"($namespace)/($repository)" | str trim
}

export def get_repository_name [] {
    let url = (git remote get-url origin)
    $url | awk -F/ '{print $NF}' | awk -F. '{print $1}'
}

export def open:github:my_prs [] {
    let root = (get_git_remote_root)
    browser-work $"https://github.com/($root)/pulls/@me"
}

