alias g = git
alias lg = lazygit
alias t = tmux
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
alias chrome = `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`

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
    let result = w stop | complete 

    if $result.exit_code == 0 {
        print $result.stdout
    }

    if ($args | is-empty)  {
        return
    }

    w start ...$args
}

export def "date from-ms" [ms] {
    $ms * 1000000 | into datetime
}

export def radio [...search] {
    let text = $search | str join ' ' | str trim

    let id = tunein search $text 
    | fzf --ansi 
    | parse "{_} id: {id}"
    | get id
    | first

    tunein play $id
}

export def youtube [url] {
    let cur_dir = pwd

    mkdir ~/Downloads/youtube
    cd ~/Downloads/youtube

    let result = yt-dlp --write-auto-subs --sub-lang en --convert-subs lrc --skip-download --restrict-filenames $url

    print $'downloaded'

    let filename = $result 
    | sed -n 's/.*file//p'
    | sed -E 's/(.*)\.vtt .*/\1.lrc/'
    | str trim

    print $'filename: ($filename)'

    cat $filename 
    | grep -v '^\[.*\]$' 
    | sed -E 's/\[[0-9:\.]*\]//g' 
    | awk '!seen[$0]++' 
    | grep -v '^[[:space:]]*$'
    | tr '\n' ' '
    | sed -E 's/\.+/./g; s/\.\s*/. /g; s/[[:space:]]+/ /g; s/^[[:space:]]+|[[:space:]]+$//g'
    | save -f $filename

    print $'file saved'

    let file = cat $filename

    truncate -s 0 $filename

    print $'file truncated'

    echo $file | deepl  translate | save -a $filename

    mv $filename $"($filename).md"

    nvim -c "lua vim.api.nvim_input('gg')" -c "FormatText" -c "w" -c "set number" $"($filename).md"

    cd $cur_dir
}
