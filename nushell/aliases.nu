alias g = git
alias lg = lazygit
alias t = tmux
alias tn = t new-session -s
alias ta = t attach-session -t
alias td  = t detach
alias n = nvim --listen $"/tmp/nvim-(tmux display-message -p '#S-#I-#{pane_pid}')"
alias d = docker
alias y = yarn
alias dc = docker-compose
alias nvm = fnm
alias yz = yazi
alias tasks = nvim ~/notes/tasks.md -c "set signcolumn=no"
alias todo = tasks
alias notes = nvim ~/notes/notes.md -c "set signcolumn=no"
alias pgcli-history = nvim ~/.config/pgcli_history 
alias q = agent --mode=ask --workspace ~/fun

let color = if (($env | get -o tmux_var_dark_theme) == '0') { 
    'gutter:0,fg+:#244566,pointer:#365987,bg+:#f0f0f0,fg+:#000022,hl:#993333,hl+:#993333' 
} else { 
    'gutter:0,bg+:-1,fg+:#244566,pointer:#365987,current-bg:#550000,current-fg:#000022' 
}
alias fzf = ^fzf --color=$"($color)" --margin=0,2 --no-separator --info=inline-right --no-scrollbar --pointer='󱞩' --prompt='󰼛 ' --layout=reverse --bind ctrl-e:close
alias chrome = `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`

def browser [link] {
    # firefox $link
    # check profiles in directory ~/Library/Application\ Support/Google/Chrome
    chrome --profile-directory="Default" $link
}

def browser-work [link] {
    # firefox $'ext+container:name=Work&url=($link)'
    # check profiles in directory ~/Library/Application\ Support/Google/Chrome
    # chrome --profile-directory="Profile 1" $link
    chrome --profile-directory="Default" $link
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

# brew install translate-shell
def trans [...words] {
    let text = $words | str join ' ' | str trim

    let lan = if ($text =~ '[а-яА-Я]') {
        'ru:en'
    } else {
        'en:ru'
    }

    ^trans $lan -show-original no -show-prompt-message no -show-languages no $text;
}

def dl [] {
    let result = d ps -a 
    | from ssv -a 
    | each { $"(ansi red)($in.NAMES) (ansi white)($in.PORTS)" } 
    | to text
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

def "date from-ms" [ms] {
    $ms * 1000000 | into datetime
}

def radio [...search] {
    let id = tunein search ($search | str join ' ' | str trim)
    | fzf --ansi 
    | parse "{_} id: {id}"
    | $in.id.0

    tunein play $id
}

def youtube [url] {
    let cur_dir = pwd

    mkdir ~/Downloads/youtube
    cd ~/Downloads/youtube

    let result = yt-dlp --write-auto-subs --sub-lang en --convert-subs lrc --skip-download --restrict-filenames $url

    print $'downloaded'

    let filename = $result 
    | sed -n 's/.*file//p'
    | sed -E 's/(.*)\.vtt .*/\1.lrc/'
    | str trim

    mut i = 1
    while (cat $filename | is-empty) and $i < 10 {
        print 'file is empty'
        sleep 1sec
        $i += 1
    }

    cat $filename 
    | grep -v '^\[.*\]$' 
    | sed -E 's/\[[0-9:\.]*\]//g' 
    | awk '!seen[$0]++' 
    | grep -v '^[[:space:]]*$'
    | tr '\n' ' '
    | sed -E 's/\.+/./g; s/\.\s*/. /g; s/[[:space:]]+/ /g; s/^[[:space:]]+|[[:space:]]+$//g; s/\>\> //g'
    | save -f $filename

    print $'file saved'

    let file = cat $filename

    truncate -s 0 $filename

    print $'file truncated'

    echo $file | deepl translate | save -a $filename

    mv $filename $"($filename).md"

    nvim -c "lua vim.api.nvim_input('gg')" -c "FormatText" -c "w" -c "set number" $"($filename).md"

    cd $cur_dir
}

def notify:apple [] {
    tee { $in }
    osascript -e 'display notification "Finished" sound name "Blow"'
}

def cut_image_for_pocket_book [img] {
    magick $img -resize "1072x1448^" -gravity center -extent 1072x1448 -colorspace Gray -level 5%,95% output.jpg
}

def history-fzf [] {
    let h = history 
    | upsert command { |$item| $item.command | str trim }
    | uniq-by command

    try {
        let index = $h
        | enumerate 
        | each {|$i| $"($i.index) ($i.item.command)" } 
        | to text
        | fzf --with-nth 2..
        | split row (char space)
        | first 
        | into int 

        $h 
        | get $index
        | get command 
        | commandline edit $in
    }
}

def test [] {
}
