export def gc [message] {
    let ticket = git rev-parse --abbrev-ref HEAD
        | split row '/'
        | last

    git add -A
    git commit -m $"($ticket): ($message | str capitalize)"
}

export def nvim-review [] {
    let branch = gh pr list -s open --limit 30 --json title,headRefName,author
    | from json
    | each { $"($in.headRefName) (ansi green)($in.author.login) (ansi green)($in.title)" }
    | str join (char newline) 
    | fzf --ansi --with-nth 2..
    | split row ' '
    | first

    git fetch origin $branch
    git ch $branch

    nvim -c "DiffviewOpen origin/master...HEAD"
}

export def open-pr [] {
    let url = gh pr list -s open --limit 30 --json title,url,author
    | from json
    | each { $"($in.url) (ansi green)($in.author.login) (ansi red)($in.title)" }
    | str join (char newline) 
    | fzf --ansi --with-nth 2..
    | split row ' '
    | first

    browser-work $url
}
