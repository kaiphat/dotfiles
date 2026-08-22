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
    gh pr list -s open --limit 20 --json title,url,author
    | from json
    | each { $"($in.url) (ansi green)($in.author.login) (ansi red)($in.title)" }
    | to text
    | fzf --ansi --with-nth 2..
    | split row (char space)
    | first
    | browser-work $in
}

export def "g ch" [to_branch?] {
    if ($to_branch | is-not-empty) {
        ^git ch $to_branch | return
    }

    let current_branch = ^git branch --show-current | str trim

    try {
        ^git bl 
        | split row (char newline)
        | where { $in | str contains $current_branch | not $in }
        | to text
        | fzf --ansi
        | split row (char space)
        | first 
        | ^git ch $in 
    }
}

export def "g clone" [url: string] {
    git clone url

    url 
    | parse '{_}/{folder}.git' 
    | get folder
    | first
    | if $in != null {
        cd $in
    }
}
