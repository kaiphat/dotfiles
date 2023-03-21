import os
import subprocess
from libqtile import bar, layout, widget
from libqtile.config import EzKey as Key, Click, Drag, Group, Match, Screen
from libqtile.lazy import lazy

from libqtile import hook


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/dotfiles/scripts/autostart.sh')
    subprocess.Popen([home])


mod = 'mod4'


keyboard = widget.KeyboardLayout(
    configured_keyboards=['us', 'ru'])

keys = [
    Key('M-h', lazy.layout.left()),
    Key('M-l', lazy.layout.right()),
    Key('M-j', lazy.layout.down()),
    Key('M-k', lazy.layout.up()),

    Key('M-S-h', lazy.layout.shuffle_left()),
    Key('M-S-l', lazy.layout.shuffle_right()),
    Key('M-S-j', lazy.layout.shuffle_down()),
    Key('M-S-k', lazy.layout.shuffle_up()),

    Key('M-C-h', lazy.layout.grow_left()),
    Key('M-C-l', lazy.layout.grow_right()),
    Key('M-C-j', lazy.layout.grow_down()),
    Key('M-C-k', lazy.layout.grow_up()),

    # Key([mod], 'n', lazy.layout.normalize()),
    # Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),
    Key('M-S-c', lazy.window.kill()),
    # Key([mod], 'r', lazy.spawncmd()),
    # Key([mod], 'Tab', lazy.next_layout()),

    Key('M-C-r', lazy.reload_config()),
    Key('M-C-q', lazy.shutdown()),

    Key('M-S-C-r', lazy.spawn('reboot')),
    Key('M-S-C-q', lazy.spawn('poweroff')),

    Key('M-<Return>', lazy.spawn('wezterm')),
    Key('M-e', lazy.spawn('thunar')),
    Key('M-d', lazy.spawn('rofi -show drun')),
    Key('M-S-b', lazy.spawn('brave')),
    Key('M-S-s', lazy.spawn('slack')),
    Key('M-S-t', lazy.spawn('steam')),
    Key('M-S-m', lazy.spawn('telegram-desktop')),

    Key('M-<space>', lazy.widget['keyboardlayout'].next_keyboard()),

    Key('Print', lazy.spawn('~/dotfiles/scripts/scrot.sh')),
    Key('M-Print', lazy.spawn('~/dotfiles/scripts/scrot_full.sh')),

    Key('<XF86AudioMute>', lazy.spawn(
        'pactl set-sink-mute @DEFAULT_SINK@ toggle')),
    Key('<XF86AudioLowerVolume>', lazy.spawn(
        'pactl set-sink-volume @DEFAULT_SINK@ -5%')),
    Key('<XF86AudioRaiseVolume>', lazy.spawn(
        'pactl set-sink-volume @DEFAULT_SINK@ +5%')),
]

keyboard = widget.KeyboardLayout(
    configured_keyboards=['us', 'ru'])

groups = [Group(i) for i in '123456789']

for i in groups:
    keys.extend([
        Key(f"M-{i.name}", lazy.group[i.name].toscreen()),
        # Key(f"M-S-{i.name}", lazy.window.togroup(i.name, switch_group=True)),
    ])

layouts = [
    layout.Max(margin=10, border_width=0),
    layout.Bsp(margin=10, border_width=0),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='mononoki Nerd Font',
    fontsize=11,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ('#ff0000', '#ffffff'),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox('default config', name='default'),
                widget.TextBox('Press &lt;M-r&gt; to spawn',
                               foreground='#d75f5f'),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

mouse = [
    Drag("M-1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag("M-3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click("M-2", lazy.window.bring_to_front()),
    Click("M-S-1", lazy.window.toggle_floating()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
