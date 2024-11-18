alias g = git
alias lg = lazygit
alias t = tmux
alias n = nvim
alias d = docker
alias y = yarn
alias dc = docker-compose
alias tn = t new-session -s
alias ta = t attach-session -t
alias td  = t detach
alias dcr = dc restart
alias di = d inspect
alias nvm = fnm
alias core-open = ^open
alias todo = n ~/notes/notes/deals.md -c "set signcolumn=no"
alias notes = n ~/notes/notes/notes.md -c "set signcolumn=no"
alias fzf = ^fzf --color="gutter:-1,bg+:-1,fg+:#244566,pointer:#365987" --margin=0,2 --no-separator --info=inline-right --no-scrollbar --pointer='󱞩' --prompt='󰼛 ' --layout=reverse --bind ctrl-e:close

def ds [] {
  let containers = (d ps -q | lines);
  d stop ...$containers;
}
def dps [name = ''] {
  let containers = (d ps -a | from ssv | select "CONTAINER ID" STATUS CREATED NAMES PORTS);
  if $name == '' {
    $containers
  } else {
    $containers | where NAMES =~ $name
  }
}

def trans [...words] {
    let text = $words | str join ' ' | str trim
    let first_letter = $words.0 | split chars | $in.0

    mut lan = 'en:ru'
    if ($words.0 | parse --regex '[а-яА-Я]' | length) > 0 {
        $lan = 'ru:en'
    }

    if ($words | length) == 1 {
        ^trans $lan -show-original no -show-prompt-message no -show-languages no $text;
        return
    }

    ^trans $lan -show-original no -show-prompt-message no -show-languages no $text;
}
