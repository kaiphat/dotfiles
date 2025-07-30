export def gc [message] {
    let ticket = git rev-parse --abbrev-ref HEAD
        | split row '/'
        | last

    git add -A
    git commit -m $"($ticket): ($message | str capitalize)"
}

export def nvim-review [] {
    let branch = gh pr list -s open --limit 15 --json title,headRefName,author
    | from json
    | each { $"($in.headRefName) (ansi green)($in.author.login) (ansi green)($in.title)" }
    | str join (char newline) 
    | fzf --ansi --with-nth 2..
    | split row ' '
    | first

    git fetch origin $branch
    git ch $branch
    git plh

    nvim -c "Octo review"
}

export def open-pr [] {
    let url = gh pr list -s open --limit 20 --json title,url,author
    | from json
    | each { $"($in.url) (ansi green)($in.author.login) (ansi red)($in.title)" }
    | str join (char newline) 
    | fzf --ansi --with-nth 2..
    | split row ' '
    | first

    browser-work $url
}

export def "g ch" [to_branch?] {
    if ($to_branch | is-not-empty) {
        ^git ch $to_branch | return
    }

    let current_branch = ^git branch --show-current | str trim
    let branch = ^git bl 
        | split row (char newline)
        | where { $in | str contains $current_branch | not $in }
        | str join (char newline)
        | fzf --ansi 
        | complete

    if ($branch.stdout | str length) > 0 {
        $branch.stdout | split row ' ' | first | ^git ch $in
    }
}
