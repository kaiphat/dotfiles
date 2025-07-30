alias g = git
alias lg = lazygit
alias t = tmux
# alias n = nvim
alias n = nvim --listen $"/tmp/nvim-(tmux display-message -p '#S-#I-#{pane_pid}')"
alias d = docker
alias y = yarn
alias dc = docker-compose
alias tn = t new-session -s
alias ta = t attach-session -t
alias td  = t detach
alias dcr = dc restart
alias di = d inspect
alias nvm = fnm
alias yz = yazi
alias tasks = nvim ~/notes/tasks.md -c "set signcolumn=no"
alias notes = nvim ~/notes/notes.md -c "set signcolumn=no"
alias nvim-pager = nvim +Man! -c "set nowrap modifiable noreadonly buftype=nofile"
alias fzf = fzf --color="gutter:0,bg+:-1,fg+:#244566,pointer:#365987,current-bg:#393959,current-fg:#000022" --margin=0,2 --no-separator --info=inline-right --no-scrollbar --pointer='󱞩' --prompt='󰼛 ' --layout=reverse --bind ctrl-e:close

# there is bug with -l (login) flag, so i should use such hack
alias run-nu-script = nu --config ~/dotfiles/nushell/config.nu --env-config ~/dotfiles/nushell/env.nu
alias chrome = `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`
alias nu-open = open
alias open = ^open

def browser [link] {
    # firefox $link
    # check profiles in directory ~/Library/Application\ Support/Google/Chrome
    chrome --profile-directory="Default" $link
}

def browser-work [link] {
    # firefox $'ext+container:name=Work&url=($link)'
    # check profiles in directory ~/Library/Application\ Support/Google/Chrome
    chrome --profile-directory="Profile 1" $link
}

def ds [] {
  let containers = (d ps -q | lines);
  d stop ...$containers;
}

def dps [name = ''] {
  let containers = (d ps -a | from ssv -a | select "CONTAINER ID" STATUS CREATED NAMES PORTS);
  if $name == '' {
    $containers
  } else {
    $containers | where NAMES =~ $name
  }
}

def trans [...words] {
    let text = $words | str join ' ' | str trim
    let first_letter = $words.0 | split chars | $in.0

    let lan = if ($text =~ '[а-яА-Я]') {
        'ru:en'
    } else {
        'en:ru'
    }

    if ($words | length) == 1 {
        ^trans $lan -show-original no -show-prompt-message no -show-languages no $text;
        return
    }

    ^trans $lan -show-original no -show-prompt-message no -show-languages no $text;
}

def dl [] {
    let result = d ps -a 
    | from ssv -a 
    | each { $"(ansi red)($in.NAMES) (ansi white)($in.PORTS)" } 
    | str join (char newline) 
    | fzf --ansi 
    | split row ' '
    | first
    
    ^docker logs $result -f
}

def docker-patch-nerd-fonts [] {
    # docker image rm nerdfonts/patcher
    # docker pull nerdfonts/patcher:latest
    docker run --rm -v ~/dotfiles/fonts/in:/in:Z -v ~/dotfiles/fonts:/out:Z -e "PN=4" nerdfonts/patcher:latest -c --careful
    rm -rf ~/dotfiles/fonts/in/*
}

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     watson     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

alias w = watson
alias wr = watson report --day -c
def ws [...args] {
    w stop | complete
    w start ...$args
}
