def prompt [] {
    # $"\r\n(ansi magenta); "
    # $"\r\n(ansi magenta)󰼛 "
    $"\r\n(ansi light_cyan)❯ "
}

def current_dir [] {
    let current_dir = pwd

    let current_dir_abbreviated = if $current_dir == $nu.home-dir {
        '~'
    } else {
        let current_dir_relative_to_home = (
            do -i { $current_dir | path relative-to $nu.home-dir }
        )

        if ($current_dir_relative_to_home | is-empty) == false {
            $'~(char separator)($current_dir_relative_to_home)'
        } else {
            $current_dir
        }
    }

    $'(ansi light_blue)($current_dir_abbreviated)(ansi reset)'
}

def git_before [branch] {
    {
        let commits = ^git log --oneline --max-count=1 $'($branch)..origin/($branch)' | complete

        if ($commits.stdout | str length) > 0 {
            return $'(ansi red)(char branch_behind)(ansi reset)'
        }

        ''
    }
}

def git_after [branch] {
    {
        let commits = ^git log --oneline --max-count=1 $'origin/($branch)..($branch)' | complete

        if ($commits.stdout | str length) > 0 {
            return $'(ansi red)(char branch_ahead)(ansi reset)'
        }

        ''
    }
}

def git_draft [] {
    {
        let commit = ^git log --oneline --max-count=1 | complete

        if ($commit.stdout | str contains 'DRAFT') {
            return $'(ansi red)D(ansi reset)'
        }

        ''
    }
}


def git_changes [] {
    {
        let result = $'(ansi red)(char hamburger)(ansi reset)'
        let unstaged = (^git diff --quiet | complete).exit_code == 1
        if $unstaged {
            return $result
        }
        let staged = (^git diff --cached --quiet | complete).exit_code == 1
        if $staged {
            return $result
        }

        ''
    }
}

def git_async [] {
    let git_exists = ^git rev-parse --abbrev-ref HEAD | complete
    let branch = $git_exists.stdout | str trim

    if $branch == '' {
        return ''
    }

    let parts = [(git_changes) (git_before $branch) (git_after $branch) (git_draft)] 
    | enumerate
    | par-each { update item $in.item } 
    | sort-by index 
    | get item
    | str join ''

    $'(ansi yellow)($branch)(ansi reset) ($parts)'
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
            let git_cur = git_async

            if $git_cur != $git_prev {
                $git_cur | save -f (get_cache_fn)

                commandline set-prompt (left $git_cur)
            }
        } 

        left $git_prev
    }
}
