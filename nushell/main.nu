$env.config.show_banner = false
$env.config.ls.use_ls_colors = true
$env.config.table.mode = 'rounded'
$env.config.render_right_prompt_on_last_line = false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
$env.config.use_kitty_protocol = true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
$env.config.edit_mode = 'vi'
$env.config.edit_mode = 'vi'
$env.config.history = {
    max_size: 100_000 # Session has to be reloaded for this to take effect
    sync_on_enter: false # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "sqlite" # "sqlite" or "plaintext"
    isolation: true # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
}

$env.config.menus ++= [
    {
        name: completion_menu
        only_buffer_difference: false
        marker: "",
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            # selected_text: { attr: r }
            # description_text: yellow
            match_text: { attr: n, bg: red, fg: black }
            selected_match_text: { attr: n, bg: red, fg: black }
        }
    }
    {
        name: history_menu
        only_buffer_difference: true 
        marker: ""                 
        type: {
            layout: list             
            page_size: 10            
        }
        style: {
            text: cyan                   
            selected_text: { attr: r }  
            description_text: yellow      
        }
    }
]
