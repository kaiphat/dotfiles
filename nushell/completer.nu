const FISH_COMPLETE_COMMANDS = [
    nu git docker docker-compose kubectl ssh scp curl wget rg fd
]

let fish_completer = {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
        | from tsv --flexible --noheaders --no-infer
        | rename value description
        | update value {|row|
            let value = $row.value
            let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
            if ($need_quote and ($value | path exists)) {
                let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
                $'"($expanded_path | str replace --all "\"" "\\\"")"'
            } else {$value}
        }
}

let carapace_completer = {|spans: list<string>|
    try {
        carapace $spans.0 nushell ...$spans
        | from json
        | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
    } catch {
        null
    }
}

def expand-alias-spans [spans: list<string>] {
    mut result = $spans
    mut depth = 0
    loop {
        if $depth >= 5 {
            return $result
        }
        let expansion = scope aliases
            | where name == $result.0
            | get -o expansion.0

        if $expansion == null {
            return $result
        }

        $result = ($expansion | split row ' ') | append ($result | skip 1)
        $depth = $depth + 1
    }
}

$env.config.completions.algorithm = 'fuzzy'
$env.config.completions.external.enable = true
$env.config.completions.external.max_results = 50
$env.config.completions.external.completer = {|spans|
    let spans = expand-alias-spans $spans

    if ($spans.0 in $FISH_COMPLETE_COMMANDS) {
        do $fish_completer $spans
    } else {
        do $carapace_completer $spans
    }
}
