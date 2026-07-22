const GIT_PROMPT_CACHE_TTL = 2sec

def git_prompt_cache [] {
    $env | get -o __git_prompt_cache | default {
        pwd: ''
        fetched_at: null
        segment: ''
    }
}

def left [] {
    $'(current_dir_style) (git_prompt) (prompt)'
}

def prompt [] {
    $"\r\n(ansi light_cyan)❯ "
}

def current_dir_style [] {
    let current_dir = (pwd)

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

def git_prompt [] {
    let dir = pwd
    let now = date now
    let cache = git_prompt_cache

    if ($dir == $cache.pwd and $cache.fetched_at != null and ($now - $cache.fetched_at) < $GIT_PROMPT_CACHE_TTL) {
        return $cache.segment
    }

    let segment = (try { git_prompt_fetch } catch { '' })

    $env.__git_prompt_cache = {
        pwd: $dir
        fetched_at: $now
        segment: $segment
    }

    $segment
}

def git_prompt_fetch [] {
    let status = ^git status --porcelain=v1 -b | complete
    if $status.exit_code != 0 {
        return ''
    }

    let lines = ($status.stdout | str trim | lines)
    if ($lines | is-empty) {
        return ''
    }

    let header = ($lines | first)
    if not ($header | str starts-with '## ') {
        return ''
    }

    let branch = git_prompt_branch $header
    if ($branch | is-empty) or $branch == 'HEAD' {
        return ''
    }

    let dirty = ($lines | skip 1 | any {|line| ($line | str length) > 0 })
    let behind = ($header | str contains '[behind ')
    let ahead = ($header | str contains '[ahead ')

    mut draft = false
    let head = (^git log -1 --oneline | complete)
    if $head.exit_code == 0 and ($head.stdout | str contains 'DRAFT') {
        $draft = true
    }

    let markers = [
        (if $dirty { $'(ansi red)(char hamburger)(ansi reset)' } else { '' })
        (if $behind { $'(ansi red)(char branch_behind)(ansi reset)' } else { '' })
        (if $ahead { $'(ansi red)(char branch_ahead)(ansi reset)' } else { '' })
        (if $draft { $'(ansi red)D(ansi reset)' } else { '' })
    ] | str join ''

    $'(ansi yellow)($branch)(ansi reset) ($markers)'
}

def git_prompt_branch [header: string] {
    let rest = ($header | str substring 3.. | str trim)
    if ($rest | str starts-with 'HEAD (') {
        return 'HEAD'
    }
    if ($rest | str contains '...') {
        return ($rest | split row '...' | first | str trim)
    }
    if ($rest | str contains ' [') {
        return ($rest | split row ' [' | first | str trim)
    }
    $rest
}

export-env {
    $env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
    $env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
    $env.PROMPT_MULTILINE_INDICATOR = {|| "" }
    $env.PROMPT_INDICATOR = {|| '' }
    $env.PROMPT_COMMAND = {|| left }
    $env.PROMPT_COMMAND_RIGHT = {|| ''}
}
