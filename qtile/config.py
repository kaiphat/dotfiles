import os
import subprocess
import socket

from typing import List
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# settings
mod = 'mod4'

padding = 5
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
font = 'JetBrainsMono Nerd Font'
font_size = 12

browser = 'google-chrome'
home = os.path.expanduser('~')
terminal = guess_terminal('kitty')

# mappings
keys = [
    # movement
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "space", lazy.layout.next()),

    # app control
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # apps
    Key([mod], "g", lazy.spawn('google-chrome')),
    Key([mod], "p", lazy.spawn('postman')),
    Key([mod], "Return", lazy.spawn("kitty")),

    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard()),
]

groups = [Group("1", label="", layout='monadtall'),
          Group("2", label="", layout='monadtall'),
          Group("3", label="", layout='monadtall'),
          Group("4", label="", layout='monadtall'),
          Group("5", label="", layout='monadtall'),
          Group("6", label="", layout='monadtall'),
          Group("7", label="", layout='monadtall'),
          Group("8", label="", layout='monadtall'),
          Group("9", label="", layout='monadwide')]

for i in range(len(groups)):
    keys.append(Key([mod], str((i)), lazy.group[str(i)].toscreen()))
    keys.append(
        Key([mod, "shift"], str((i)), lazy.window.togroup(str(i), switch_group=True))
    )

widget_defaults = dict(
    font=font,
    fontsize=font_size,
    padding=3,
)
extension_defaults = widget_defaults.copy()

colors = [
    ["#2e3440", "#2e3440"],  # 0 background
    ["#f8f8f2", "#f8f8f2"],  # 1 foreground
    ["#3b4252", "#3b4252"],  # 2 background lighter
    ["#bf616a", "#bf616a"],  # 3 red
    ["#a3be8c", "#a3be8c"],  # 4 green
    ["#ebcb8b", "#ebcb8b"],  # 5 yellow
    ["#81a1c1", "#81a1c1"],  # 6 blue
    ["#b48ead", "#b48ead"],  # 7 magenta
    ["#88c0d0", "#88c0d0"],  # 8 cyan
    ["#4c566a", "#4c566a"],  # 9 grey
    ["#e5e9f0", "#e5e9f0"],  # 10 white
    ["#d08770", "#d08770"],  # 11 orange
    ["#8fbcbb", "#8fbcbb"],  # 12 super cyan
    ["#5e81ac", "#5e81ac"],  # 13 super blue
    ["#242831", "#242831"],  # 14 super dark background
    ["#708090", "#708090"]   # 15
]

layout_theme = {
    "border_width": 0,
    "margin": padding,
    "border_focus": colors[9],
    "border_normal": colors[0]
}

layouts = [
    layout.MonadWide(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme)
]

widget_defaults = dict(
    font=font,
    fontsize=font_size,
    padding=padding,
    foreground = colors[15],
    background = colors[0]
)

extension_defaults = widget_defaults.copy()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

screens = [
    Screen(
        wallpaper = "/home/ilya/Pictures/jerry-zhang-bcW3NDWHMwc-unsplash.jpg",
        wallpaper_mode = "fill",
        top = bar.Bar(
            [
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    ),
                widget.GroupBox(
                    margin_y = 3,
                    margin_x = 0,
                    padding_y = 5,
                    padding_x = 3,
                    borderwidth = 3,
                    inactive = colors[2],
                    active = colors[15],
                    rounded = False,
                    highlight_color = colors[9],
                    highlight_method = "line",
                    this_current_screen_border = colors[15],
                    this_screen_border = colors[15],
                    other_current_screen_border = colors[15],
                    other_screen_border = colors[9],
                    foreground = colors[15],
                    background = colors[0]
                    ),
                widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    ),
                widget.Prompt(
                    prompt = prompt,
                    padding = 6,
                    ),
                widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    ),
                widget.WindowName(
                    padding = 5,
                    ),
                widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    ),
                widget.TextBox(
                    text = " ⟳",
                    fontsize = 15,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal)}
                    ),
                widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    ),
                widget.TextBox(
                        text = "|",
                        fontsize = 12,
                        foreground = colors[2],
                        ),
                widget.Net(
                        format = '{down} ↓↑ {up}',
                        padding = 5,
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.TextBox(
                        text = "|",
                        fontsize = 12,
                        foreground = colors[2],
                        ),
                widget.Memory(
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e bpytop')},
                        padding = 5
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.TextBox(
                        text = "|",
                        fontsize = 12,
                        foreground = colors[2],
                        ),
                widget.CPU(
                        padding = 5
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.TextBox(
                        text = "|",
                        fontsize = 12,
                        foreground = colors[2],
                        ),
                widget.Wttr(
                        padding = 1,
                        location={'Drogichin': 'Drogichin'},
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.TextBox(
                        text = "|",
                        fontsize = 12,
                        foreground = colors[2],
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.KeyboardLayout(
                       foreground = colors[1],
                       background = colors[8],
                       configured_keyboards=['us', 'ru'],
                       update_interval=2,
                       ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.TextBox(
                        text = "|",
                        fontsize = 12,
                        foreground = colors[2],
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.Clock(
                        format = "%d.%m.%y - %H:%M"
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.Pomodoro(
                        length_long_break=1,
                        length_short_break=1,
                        length_pomodori=1,
                        notification_on=True
                        ),
                widget.CurrentLayoutIcon(
                        custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                        padding = 5,
                        scale = 0.7
                        ),
                widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        ),
                widget.Notify(
                        foreground="FF0000", 
                        fontsize=18,
                        audiofile='/home/ilya/Downloads/nnn.mp3'
                        ),
                ],
            size = 22,
            opacity = 0.9
            ),
        )
]

# rules
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"

# startup
@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])
