let base00 = "#24273a" # base
let base01 = "#1e2030" # mantle
let base02 = "#363a4f" # surface0
let base03 = "#494d64" # surface1
let base04 = "#5b6078" # surface2
let base05 = "#cad3f5" # text
let base06 = "#f4dbd6" # rosewater
let base07 = "#b7bdf8" # lavender
let base08 = "#ed8796" # red
let base09 = "#f5a97f" # peach
let base0a = "#eed49f" # yellow
let base0b = "#a6da95" # green
let base0c = "#8bd5ca" # teal
let base0d = "#8aadf4" # blue
let base0e = "#c6a0f6" # mauve
let base0f = "#f0c6c6" # flamingo

let theme = {
    separator: $base03
    leading_trailing_space_bg: $base04
    header: $base0b
    date: $base0e
    filesize: $base0d
    row_index: $base0c
    bool: $base08
    int: $base0b
    duration: $base08
    range: $base08
    float: $base08
    string: $base04
    nothing: $base08
    binary: $base08
    cellpath: $base08
    hints: dark_gray

    shape_garbage: { fg: "#bbbbbb" bg: "#FF0000" attr: b}
    shape_bool: $base0d
    shape_int: { fg: $base0e attr: b}
    shape_float: { fg: $base0e attr: b}
    shape_range: { fg: $base0a attr: b}
    shape_internalcall: { fg: $base0c attr: b}
    shape_external: $base0c
    shape_externalarg: { fg: $base0b attr: b}
    shape_literal: $base0d
    shape_operator: $base0a
    shape_signature: { fg: $base0b attr: b}
    shape_string: $base0b
    shape_filepath: $base0d
    shape_globpattern: { fg: $base0d attr: b}
    shape_variable: $base0e
    shape_flag: { fg: $base0d attr: b}
    shape_custom: {attr: b}
}

$env.config.color_config = $theme
