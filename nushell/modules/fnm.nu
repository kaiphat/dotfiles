export-env { 
    ^fnm env --shell bash
        | lines
        | str replace 'export ' ''
        | str replace -a '"' ''
        | split column '='
        | rename name value
        | where name != "FNM_ARCH" and name != "PATH"
        | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value }
        | load-env

    $env.PATH ++= [$"($env.FNM_MULTISHELL_PATH)/bin"]
}
