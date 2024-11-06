alias g = git
alias t = tmux
alias n = nvim
alias d = docker
alias y = yarn
alias dc = docker-compose
alias tn = t new-session -s
alias ta = t attach-session
alias td  = t detach
alias dcr = dc restart
alias di = docker inspect
alias nvm = fnm
alias core-open = ^open
alias todo = nvim ~/notes/notes/deals.md -c "set signcolumn=no"
alias notes = nvim ~/notes/notes/notes.md -c "set signcolumn=no"
alias fzf = fzf --color="gutter:-1,bg+:-1,fg+:#244566,pointer:#365987" --margin=0,2 --no-separator --info=inline-right --no-scrollbar --pointer='󱞩' --prompt='󰼛 ' --layout=reverse --bind ctrl-e:close

def ds [] {
  let containers = (docker ps -q | lines);
  docker stop ...$containers;
}
def dps [name = ''] {
  let containers = (docker ps -a | from ssv | select "CONTAINER ID" STATUS CREATED NAMES PORTS);
  if $name == '' {
    $containers
  } else {
    $containers | where NAMES =~ $name
  }
}
