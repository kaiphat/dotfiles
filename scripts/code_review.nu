let prs = gh pr list -s open --limit 30 --json title,headRefName
    | from json

let selected_title = $prs
    | each { $"(ansi red)($in.title)" }
    | str join (char newline) 
    | fzf --ansi 
    
let branch = $prs | where { $in.title == $selected_title } | first | get headRefName

git fetch origin $branch
git ch $branch

nvim -c "DiffviewOpen origin/master...HEAD"
