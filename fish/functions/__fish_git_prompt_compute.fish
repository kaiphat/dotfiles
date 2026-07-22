function __fish_git -a dir
    command git -C $dir --no-optional-locks $argv[2..]
end

function __fish_git_part_changes -a dir
    __fish_git $dir diff --quiet 2>/dev/null
    or begin
        echo -n '≡'
        return
    end
    __fish_git $dir diff --cached --quiet 2>/dev/null
    or echo -n '≡'
end

function __fish_git_part_before -a dir branch
    set -l commits (__fish_git $dir log --oneline --max-count=1 "$branch..origin/$branch" 2>/dev/null)
    test -n "$commits"; and echo -n '⇣'
end

function __fish_git_part_after -a dir branch
    set -l commits (__fish_git $dir log --oneline --max-count=1 "origin/$branch..$branch" 2>/dev/null)
    test -n "$commits"; and echo -n '⇡'
end

function __fish_git_part_draft -a dir
    set -l commit (__fish_git $dir log --oneline --max-count=1 2>/dev/null)
    string match -q '*DRAFT*' -- "$commit"; and echo -n 'D'
end

function __fish_git_prompt_parts_parallel -a dir branch
    set -l tmp (mktemp -d -t fish_git_prompt)
    set -l f_changes $tmp/changes
    set -l f_before $tmp/before
    set -l f_after $tmp/after
    set -l f_draft $tmp/draft

    begin
        __fish_git_part_changes $dir >$f_changes
    end &
    begin
        __fish_git_part_before $dir $branch >$f_before
    end &
    begin
        __fish_git_part_after $dir $branch >$f_after
    end &
    begin
        __fish_git_part_draft $dir >$f_draft
    end &
    wait

    set -l parts (cat $f_changes $f_before $f_after $f_draft)
    command rm -rf $tmp
    echo -n $parts
end

function __fish_git_prompt_compute -a dir
    set -l branch (__fish_git $dir rev-parse --abbrev-ref HEAD 2>/dev/null)
    or return 1

    set -l parts (__fish_git_prompt_parts_parallel $dir $branch)
    echo -n "$branch $parts"
end
