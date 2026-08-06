def left [] {
  $'(current_dir_style) (git_async) (prompt)'
}

def prompt [] {
  # $"\r\n(ansi magenta); "
  # $"\r\n(ansi magenta)󰼛 "
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

def git_before [branch] {
  {
    git log --oneline --max-count=1 $'($branch)..origin/($branch)'
    | str length
    | if $in > 0 { $'(ansi red)(char branch_behind)(ansi reset)' } else { '' }
  }
}

def git_after [branch] {
  {
    git log --oneline --max-count=1 $'origin/($branch)..($branch)'
    | str length
    | if $in > 0 { $'(ansi red)(char branch_ahead)(ansi reset)' } else { '' }
  }
}

def git_draft [] {
  {
    git log --oneline --max-count=1
    | str contains 'DRAFT' 
    | if $in { $'(ansi red)D(ansi reset)' } else { '' }
  }
}


def git_changes [] {
  {
    let result = $'(ansi red)(char hamburger)(ansi reset)'

    git diff --quiet 
    | complete
    | if $in.exit_code == 1 { return $result }

    git diff --cached --quiet 
    | complete
    | if $in.exit_code == 1 { return $result }

    ''
  }
}

def git_async [] {
  let branch = git rev-parse --abbrev-ref HEAD 
  | complete
  | $in.stdout
  | str trim

  if $branch == '' {
    return ''
  }

  let parts = [(git_changes) (git_before $branch) (git_after $branch) (git_draft)] 
  | enumerate
  | par-each {|s| update item (do $s.item) } 
  | sort-by item 
  | get item
  | str join ''

  $'(ansi yellow)($branch)(ansi reset) ($parts)'
}


export-env { 
  $env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
  $env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
  $env.PROMPT_MULTILINE_INDICATOR = {|| "" }
  $env.PROMPT_INDICATOR = {|| '' }
  $env.PROMPT_COMMAND = {|| left }
  $env.PROMPT_COMMAND_RIGHT = {|| ''}
}
