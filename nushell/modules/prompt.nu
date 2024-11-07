def left [] {
    $'(current_dir_style) (git_branch) (git) (prompt)'
}

def prompt [] {
    $"\r\n(ansi red)󰼛 "
}

def current_dir_style [] {
    let current_dir = ($env.PWD)

    let current_dir_abbreviated = if $current_dir == $nu.home-path {
        '~'
    } else {
        let current_dir_relative_to_home = (
            do --ignore-errors { $current_dir | path relative-to $nu.home-path } | str join
        )

        if ($current_dir_relative_to_home | is-empty) == false {
            $'~(char separator)($current_dir_relative_to_home)'
        } else {
            $current_dir
        }
    }

    $'(ansi light_blue)($current_dir_abbreviated)(ansi reset)'
}

def git [] {
    let unstaged = {
        (^git diff --quiet | complete).exit_code == 1
    }
    let staged = {
        (^git diff --cached --quiet | complete).exit_code == 1
    }
    let upstream = {
        let stat = ^git --no-optional-locks status --porcelain=2 --branch 
            | lines
            | where ($it | str starts-with '# branch.ab')
            | split column ' ' col1 col2 ahead behind

        let behind = $stat | get behind | first | into int
        let ahead = $stat | get ahead | first | into int

        {
            behind: $behind
            ahead: $ahead
        }
    }

    let result = ([
        $staged
        $unstaged 
        $upstream 
    ] | par-each {|it| do $it})

    let changes = if ($result.0 or $result.1) { char hamburger }
    let before = if $result.2.behind < 0 { char branch_behind }
    let after = if $result.2.ahead > 0 { char branch_ahead }

    $'(ansi red)($changes)($before)($after)(ansi reset)'
}

def git_branch [] {
    do -i {
        let branch = do -i { ^git rev-parse --abbrev-ref HEAD } | str trim
        if ($branch | str length) > 0 {
            return $'(ansi yellow)($branch)(ansi reset)'
        }
        return ''
    }
}

export-env { 
    $env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
    $env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
    $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
    $env.PROMPT_INDICATOR = {|| '' }
    $env.PROMPT_COMMAND = {|| left }
    $env.PROMPT_COMMAND_RIGHT = {|| ''}
}
