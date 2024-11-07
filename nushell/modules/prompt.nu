def left [] {
    $'(current_dir_style) (git) (prompt)'
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
            do -i { $current_dir | path relative-to $nu.home-path } | str join
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
    let git_exists = ^git rev-parse --abbrev-ref HEAD | complete
    let branch = $git_exists.stdout | str trim

    if $branch == '' {
        return ''
    }

    let upstream = do {
        let stats = ^git --no-optional-locks status --porcelain=2 --branch 
            | lines
            | where ($it | str starts-with '# branch.ab')
            | split column ' ' col1 col2 ahead behind

        if ($stats | length) == 0 {
            return ''
        }

        let behind = $stats | get behind | first | into int | if $in < 0 { char branch_behind }
        let ahead = $stats | get ahead | first | into int | if $in > 0 { char branch_ahead }
        $'(ansi red)($behind)($ahead)(ansi reset)'
    }
    let changes = do {
        let unstaged = (^git diff --quiet | complete ).exit_code == 1
        if $unstaged {
            return $'(ansi red)(char hamburger)(ansi reset)'
        }
        let staged = (^git diff --cached --quiet | complete).exit_code == 1
        if $staged {
            return $'(ansi red)(char hamburger)(ansi reset)'
        }
    }

    $'(ansi yellow)($branch)(ansi reset) ($changes)($upstream)'
}

export-env { 
    $env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
    $env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
    $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
    $env.PROMPT_INDICATOR = {|| '' }
    $env.PROMPT_COMMAND = {|| left }
    $env.PROMPT_COMMAND_RIGHT = {|| ''}
}
