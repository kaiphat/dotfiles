# fish waits for `begin; …; end &` jobs from fish_prompt handlers — git must run in a
# detached `fish -c` subprocess (same idea as fish-async-prompt + disown).

if not set -q __fish_git_prompt_dir
    set -g __fish_git_prompt_dir (mktemp -d -t fish_git_prompt)
end

set -g __fish_git_prompt_file "$__fish_git_prompt_dir/$fish_pid.git"
set -g __fish_git_prompt_token_file "$__fish_git_prompt_dir/$fish_pid.tok"
set -q __fish_git_prompt_signal
or set -g __fish_git_prompt_signal USR1

function __fish_git_prompt_cleanup --on-event fish_exit
    command rm -f "$__fish_git_prompt_file" "$__fish_git_prompt_token_file"
    command rm -rf "$__fish_git_prompt_dir"
end

function __fish_git_prompt_repaint --on-signal $__fish_git_prompt_signal
    commandline -f repaint 2>/dev/null
end

function __fish_git_prompt_reset --on-variable PWD
    set -g __fish_git_prompt_token (random)
    echo $__fish_git_prompt_token >"$__fish_git_prompt_token_file"
    command rm -f "$__fish_git_prompt_file"
    commandline -f repaint 2>/dev/null
end

function __fish_git_prompt_worker --on-event fish_prompt
    set -l token (random)
    set -g __fish_git_prompt_token $token
    echo $token >"$__fish_git_prompt_token_file"

    set -l dir (string escape -- $PWD)
    set -l outfile (string escape -- $__fish_git_prompt_file)
    set -l tokfile (string escape -- $__fish_git_prompt_token_file)
    set -l parent $fish_pid
    set -l sig $__fish_git_prompt_signal

    # Subprocess is not waited on by fish (unlike `begin … end &` in this handler).
    fish -c "
        set -l t0 (cat $tokfile)
        test \$t0 = '$token'; or exit 0
        set -l text (__fish_git_prompt_compute $dir 2>/dev/null)
        set -l t1 (cat $tokfile)
        test \$t1 = '$token'; or exit 0
        echo -n \$text >$outfile
        kill -s $sig $parent 2>/dev/null
    " &
end

function __fish_git_prompt_ensure_cached
    test -s "$__fish_git_prompt_file"
    and return

    # Nested fish (e.g. nushell → fish): SIGUSR1 repaint often does not refresh
    # the first prompt, so fill the cache before drawing when we're a subshell.
    test "$SHLVL" -le 1
    and return

    set -l text (__fish_git_prompt_compute $PWD 2>/dev/null)
    test -n "$text"
    and echo -n "$text" >"$__fish_git_prompt_file"
end

function fish_prompt
    __fish_git_prompt_ensure_cached

    set_color cyan
    echo -n (prompt_pwd)
    if test -s "$__fish_git_prompt_file"
        set_color yellow
        echo -n " "(string collect <"$__fish_git_prompt_file")
        set_color normal
    end
    echo
    set_color brcyan
    echo -n "❯ "
    set_color normal
end
