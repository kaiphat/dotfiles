export-env {
    $env.config = (
        $env.config?
        | default {}
        | upsert hooks { default {} }
        | upsert hooks.env_change { default {} }
        | upsert hooks.env_change.PWD { default [] }
    )
    let __zoxide_hooked = (
        $env.config.hooks.env_change.PWD | any { try { get __zoxide_hook } catch { false } }
    )
    if not $__zoxide_hooked {
        $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {
            __zoxide_hook: true,
            code: {|_, dir| zoxide add -- $dir}
        })
    }
}

def "nu-complete zoxide path" [context: string] {
    let parts = $context | split row " " | skip 1
    {
        options: {
            sort: false
            completion_algorithm: fuzzy
            positional: true
            case_sensitive: false
        }
        completions: (zoxide query --list --exclude $env.PWD -- ...$parts | lines)
    }
}

def --env --wrapped __zoxide_z [...rest: string] {
    if ($rest | is-empty) {
        cd
        return
    }

    let norm_path = if ($rest | last | path exists) {
        cd ($rest | last)
    } else {
        cd (zoxide query --exclude $env.PWD -- ...$rest | str trim -r -c "\n")
    }
}

def --env --wrapped z [...rest: string@"nu-complete zoxide path"] {
    __zoxide_z ...$rest
}
