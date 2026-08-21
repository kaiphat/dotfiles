def prompt [] {
    $"\r\n(ansi light_cyan)❯ "
}

def current_dir [] {
    $'(ansi light_blue)(pwd | str replace $env.HOME '~')(ansi reset)'
}

def git_before [branch] {
    {
        git log --oneline --max-count=1 $'($branch)..origin/($branch)' 
        | complete
        | get stdout
        | is-not-empty  
        | if $in { $'(ansi red)(char branch_behind)(ansi reset)' }
    }
}

def git_after [branch] {
    {
        git log --oneline --max-count=1 $'origin/($branch)..($branch)'
        | complete
        | get stdout
        | is-not-empty 
        | if $in { $'(ansi red)(char branch_ahead)(ansi reset)' }
    }
}

def git_draft [] {
    {
        ^git log --oneline --max-count=1 
        | complete
        | get stdout
        | str contains DRAFT
        | if $in { $'(ansi red)D(ansi reset)' }
    }
}

def git_changes [] {
    {
        let result = $'(ansi red)(char hamburger)(ansi reset)'

        ^git diff --quiet 
        | complete
        | get exit_code
        | if $in == 1 { $result } else {
            ^git diff --quiet --cached 
            | complete
            | get exit_code
            | if $in == 1 { $result }
        }
    }
}

def git_async [] {
    ^git rev-parse --abbrev-ref HEAD 
    | complete
    | get stdout
    | str trim
    | if ($in | is-not-empty) {
        let branch = $in;

        [(git_changes) (git_before $branch) (git_after $branch) (git_draft)] 
        | enumerate
        | par-each { update item $in.item } 
        | sort-by index 
        | get item
        | str join ''
        | $'(ansi yellow)($branch)(ansi reset) ($in)'
    }
}

def left [git] {
    $'(current_dir) ($git) (prompt)'
}

def get_cache_fn [] {
    $'/tmp/git_prompt_cache_($nu.pid)'
}

export-env { 
    $env.PROMPT_INDICATOR_VI_INSERT = { '' }
    $env.PROMPT_INDICATOR_VI_NORMAL = { '' }
    $env.PROMPT_MULTILINE_INDICATOR = { '' }
    $env.PROMPT_INDICATOR = { '' }
    $env.PROMPT_COMMAND_RIGHT = { '' }
    $env.PROMPT_COMMAND = { 
        let git_prev = try { open (get_cache_fn) } catch { '' }

        job spawn { 
            let git_cur = git_async | default ''

            if $git_cur != $git_prev {
                $git_cur | save -f (get_cache_fn)

                commandline set-prompt (left $git_cur)
            }
        } 

        left $git_prev
    }
}
