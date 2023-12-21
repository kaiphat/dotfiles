# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   ENVIROMENTS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

set -gx nvm_default_version v20.8.1
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man! -c "set nowrap"'
set -gx PAGER 'nvim +Man! -c "set nowrap"'
set -gx LUA_DIR /usr/bin/lua
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient_21_8
set -U fish_greeting
set -U ignoreeof true
set -U SXHKD_SHELL sh
set -U XDG_CONFIG_HOME ~/.config
set -U TERMINFO /usr/share/terminfo

bind \cd delete-char
bind \cw backward-kill-word

function fish_right_prompt
end

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     paths     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

fish_add_path -aP $snap_bin_path
fish_add_path -aP /opt/homebrew/bin
fish_add_path -aP $ANDROID_HOME/emulator
fish_add_path -aP $ANDROID_HOME/tools
fish_add_path -aP $ANDROID_HOME/tools/bin
fish_add_path -aP $ANDROID_HOME/platform-tools
fish_add_path -aP /opt/ReactNativeDebugger
fish_add_path -aP /usr/local/go/bin
fish_add_path -aP /usr/.local/bin
fish_add_path -aP /usr/bin/lua
fish_add_path -aP /usr/bin/i3
fish_add_path -aP /usr/bin/i3bar
fish_add_path -aP $HOME/go/bin
fish_add_path -aP $HOME/.cargo/bin
fish_add_path -aP $HOME/.krew/bin
fish_add_path -aP $HOME/.local/share/bob/nvim-bin
fish_add_path -aP $HOME/.local/bin/razer-cli
fish_add_path -aP $HOME/.yarn/bin
fish_add_path -aP $HOME/.local/bin
fish_add_path -aP $HOME/.local/share/nvim/mason/bin/


set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"
if [ -f '/Users/ilyapu/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/ilyapu/Downloads/google-cloud-sdk/path.fish.inc'; end

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   ALIASES   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     edit     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

alias edit-aliases "nvim ~/.config/fish/conf.d/aliases.fish"
alias todo "nvim ~/notes/deals.norg -c \"set signcolumn=no\""
alias notes "nvim ~/notes/notes.norg -c \"set signcolumn=no\""

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     docker     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

alias d "docker"
alias dstop "sudo systemctl stop docker.socket"
function dstart
  sudo systemctl start docker.service
  ds
end
function ds
    set containers (d ps -q)
    if test -z "$containers"; echo 'there is not running containers'; return; end
    d stop $containers
end
alias dc "docker-compose"
alias dcr "dc restart"
alias di "docker inspect"
alias du "dc up --force-recreate -d -V $1"
alias dub "dc up --force-recreate --build -d -V $1"
function docker-patch-nerd-font 
    docker run --rm -v ~/dotfiles/fonts/in:/in:Z -v ~/dotfiles/fonts:/out:Z nerdfonts/patcher -c --careful
    rm -rf ~/dotfiles/fonts/in/*
end

alias w "watson"
alias wr "w report --day"
alias wstart "watson start"
alias wst "watson stop"
function wry
  set yesterday (date +%Y-%m-%d --date='yesterday')
  w report --from $yesterday --to $yesterday
end

alias g "git"
alias k "kubectl"
alias tn "tmux new-session -s"
alias ta "tmux attach-session"
alias td "tmux detach"
alias st "speedtest"
alias y "yarn"
alias grep "grep -i --color"
# alias n "nvim --listen /tmp/nvim-server-$(tmux display-message -p '#S').pipe"
alias n "nvim"
alias nread "nvim -c \"set nowrap\""
alias req "http -p mbh"
alias mkdir "mkdir -p"
alias less "less -MSx4 -FXR --shift 10"
alias ls "ls -A --color=auto"
alias rm "rm -rfv"
alias cp "cp -r -v"
alias clip "xclip -selection c"
alias pj "xclip -o | jq '.' | clip"
alias nvim-start "nvim --startuptime _s.log -c exit && tail -100 _s.log | bat && rm _s.log"
alias ... "cd ../../"
alias lg "lazygit"

alias play:sql "n ~/play/sql/index.sql"
function change-theme
    set file ~/dotfiles/scripts/change_terminal_theme.fish
    chmod +x $file
    source $file
end
function play:ts
    cd ~/play/typescript
    n index.ts
end

alias enru "trans en:ru -show-original no -show-prompt-message no -show-languages no"
alias ruen "trans ru:en -show-original no -show-prompt-message no -show-languages no"

function dl
  d logs $argv -f -n 99
end

function dps
  d ps -a --format "table {{.ID}}\t{{.Names}}" | \
  grep $argv
end

function git-recreate-from -a root_branch
  if test -z "$root_branch"; echo 'error: need a root_branch argument'; return; end

  set branch (git branch --show-current)
  git ch $root_branch
  git bd $branch
  git plh
  git chb $branch
end

function gp -a message
  if test -z "$message"; echo '{message} is not implemented'; return; end

  set branch (git branch --show-current)

  git add -A
  git commit -m "$message"
  git push origin $branch
end

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   COLORS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

set fish_color_command '#81A1C1'
set fish_color_match 'red' '--bold' '--background=cyan'
set fish_color_search_match 'red' '--bold' '--background=red'
set fish_pager_color_prefix 'red'
set fish_color_valid_path
set fish_color_selection 'green' '--background=brblack'
set fish_color_param 'cyan'
set fish_color_keyword 'cyan'
set fish_color_autosuggestion '#5c6370'
set fish_color_quote '#6e88a6'
set fish_color_history_current '--bold'
set fish_color_host red
set fish_color_normal
set fish_color_operator 'red'

# set fish_color_cancel '-r'
# set fish_color_comment red
# set fish_color_cwd green
# set fish_color_cwd_root red
# set fish_color_end brmagenta
# set fish_color_error brred
# set fish_color_escape 'red' '--italic'
# set fish_color_host_remote red
# set fish_color_redirection brblue
# set fish_color_status red
# set fish_color_user brgreen

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   TMUX   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

function refresh_tmux_vars --on-event="fish_preexec"
  if set -q TMUX
    tmux showenv -s | string replace -rf '^((?:SSH|DISPLAY).*?)=(".*?"); export.*' 'set -gx $1 $2' | source
  end
end

# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   AUTOSTART   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
# ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

zoxide init fish | source
function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

# if status is-interactive
#     eval (zellij setup --generate-auto-start fish | string collect)
# end

if status is-interactive
and not set -q TMUX
  tmux kill-session -t 0 || true
  tmux attach -t main || tmux new -s main
end
