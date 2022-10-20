# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from typing import List
#from scripts import storage
from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.dgroups import simple_key_binder
from libqtile.config import Key, KeyChord, Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import widget
from libqtile.widget import base


mod = "mod4"
terminal = "alacritty"

################################################################################
# SETTING XTERM AS A DEFAULT TERMINAL TEMPORATLY BECAUSE I DON'T HAVE ENOUGHT  #
# TIME TO BUILD A PERFECT ST BUILD AND BECAUSE THE OLD LENOVO NOTEBOOK DOESN'T #
# HAVE A OPENGL 3.3 REQUIRED BY ALACRITTY                                      #
################################################################################

oldterminal = "xterm"
browser = "brave"

# Hooks


@hook.subscribe.client_new
def client_new(client):
    if client.name == 'Mozilla Thunderbird':
        client.togroup('9')

# Autostart

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])


keys = [
    # WINDOWS MANAGMENT
    # Window navigation

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Switching windows

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows

    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    # window modifing

    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating mode"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Volume keys
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # Audio and brightness control (not working right now)

    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse sset Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -D pulse sset Master 3%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -D pulse sset Master 3%+")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("blight set +10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("blight set -10")),

    # Language

    Key([mod], "F1", lazy.spawn("setxkbmap us"), desc="Change to US layout"),
    Key([mod], "F2", lazy.spawn("setxkbmap sk"), desc="Change to Greek layout"),

    # Applications

    ################################################################################
    # SETTING XTERM AS A DEFAULT TERMINAL TEMPORATLY BECAUSE I DON'T HAVE ENOUGHT  #
    # TIME TO BUILD A PERFECT ST BUILD AND BECAUSE THE OLD LENOVO NOTEBOOK DOESN'T #
    # HAVE A OPENGL 3.3 REQUIRED BY ALACRITTY                                      #
    ################################################################################

    #Key([mod], "Return", lazy.spawn(oldterminal), desc="Launch terminal"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "w", lazy.spawn(browser), desc="Open Brave"),
    Key([mod, "shift"], "i", lazy.spawn("inkscape"), desc="Open Inkscape"),
    Key([mod, "shift"], "s", lazy.spawn("steam"), desc="Open Steam"),
    Key([mod, "shift"], "v", lazy.spawn("virt-manager"), desc="Open Virt-manager"),
    Key([mod, "shift"], "d", lazy.spawn("discord"), desc="Open discord"),

    # Config files
    
    KeyChord([mod], "d", [
        Key([], "a", lazy.spawn("/home/thinker/.config/qtile/scripts/edit_alacritty_config.sh")),
        Key([], "q", lazy.spawn("{terminal} -e lvim /home/thinker/.config/qtile/config.py")),
        Key([], "d", lazy.spawn("{terminal} -e lvim /home/thinker/.config/dunst/dunstrc")),
        Key([], "x", lazy.spawn("{terminal} -e lvim /home/thinker/.xinitrc")),
        Key([], "s", lazy.spawn("{terminal} -e lvim /usr/lib/sddm/sddm.conf.d/default.conf"))
    ]),

    # Rofi helpers

    KeyChord([mod], "r", [
        Key([], "r", lazy.spawn("/home/thinker/.config/rofi/launchers/type-4/launcher.sh"), desc="Open Rofi"),
        Key([], "p", lazy.spawn("/home/thinker/.config/rofi/powermenu/type-1/powermenu.sh"), desc="Open Rofi powermenu"),
        Key([], "s", lazy.spawn("/home/thinker/.config/rofi/applets/bin/screenshot.sh"), desc="Open Maim Screenshot utility"),
        Key([], "q", lazy.spawn("/home/thinker/.config/rofi/applets/bin/quicklinks.sh"), desc="Open Rofi Quicklinks"),
        Key([], "c", lazy.spawn("/home/thinker/.config/qtile/scripts/rofi-calc.sh"), desc="Open Rofi calculator"),
        Key([], "n", lazy.spawn("/home/thinker/.config/qtile/scripts/rofi-network-manager.sh"), desc="Open Rofi calculator"),
    ]),

    # Toggle between different layouts as defined below

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),

    # Restart and quit Qtile

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]


# My workspaces

# Create labels for groups and assign them a default layout.
groups = []

#group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus"]
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

#group_labels = ["", "", "", "", "", "", "", "", "", "", ""]
#group_labels = ["TERM", "WWW", "FILE", "DRAW", "MUSC", "DEV", "VIRT", "CHAT", "MAIL", "PLAY", "OPT"]
group_labels = ["TERM", "WEB", "FILE", "DRAW", "MUSC", "DEV", "VIRT", "CHAT", "MAIL", "PLAY"]

#group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall",  "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall" ]
group_layouts = ["monadtall", "monadtall", "monadtall",  "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# Add group specific keybindings
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Mod + number to move to that group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="Move focused window to new group."),
    ])

# Default theme setting for layouts
layout_theme = {'border_width': 2,
                'margin': 5,
                'font': "Cantarell",
                'font_size': 10,
                'border_focus': "bd93f9",
                'border_normal': "555555",
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Tile(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# colors for dracula theme


def init_colors():
    return [["#282a36", "#282a36"],  # color 0  | bg
            ["#282a36", "#282a36"],  # color 1  | bg
            ["#f8f8f2", "#f8f8f2"],  # color 2  | fg
            ["#ff5555", "#ff5555"],  # color 3  | red
            ["#50fa7b", "#50fa7b"],  # color 4  | green
            ["#f1fa8c", "#f1fa8c"],  # color 5  | yellow
            ["#ffb86c", "#ffb86c"],  # color 6  | orange
            ["#bd93f9", "#bd93f9"],  # color 7  | blue
            ["#ff79c6", "#ff79c6"],  # color 8  | magenta
            ["#8be9fd", "#8be9fd"],  # color 9  | cyan
            ["#bbbbbb", "#bbbbbb"]]  # color 10 | white


def init_separator():
    return widget.Sep(
                size_percent=60,
                margin=5,
                linewidth=2,
                background=colors[1],
                foreground="#555555")


def nerd_icon(nerdfont_icon, fg_color):
    return widget.TextBox(
                font="Iosevka Nerd Font",
                fontsize=15,
                text=nerdfont_icon,
                foreground=fg_color,
                background=colors[1])


def init_edge_spacer():
    return widget.Spacer(
                length=4,
                background=colors[1])


colors = init_colors()
sep = init_separator()
space = init_edge_spacer()


widget_defaults = dict(
    font="Source Code Pro Medium",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
            # Left Side of the bar

            widget.Spacer(
                length=1,
                background=colors[1]
            ),
            widget.Image(
                filename="~/.config/qtile/python.png",
                background=colors[1],
                foreground=colors[2],
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn(
                        f'{terminal} -e vim /home/thinker/.config/qtile/config.py'
                    ),
                    'Button3': lambda: qtile.cmd_spawn(
                        f'{terminal} -e vim /home/thinker/.config/qtile/autostart.sh'
                    )
                }
            ),
            widget.GroupBox(
                #font="Iosevka Nerd Font",
                font="Source Code Pro bold",
                fontsize=10,
                margin_y=4,
                margin_x=4,
                padding_y=5,
                padding_x=5,
                forground=colors[2],
                background=colors[1],
                borderwidth=2,
                disable_drag=True,
                highlight_method="line",
                highlight_color=['282a36'],
                this_screen_border=colors[4],
                this_current_screen_border=colors[7],
                active=colors[6],
                inactive=colors[2],
                rounded=False,
                use_mouse_wheel=False
            ),
            sep,
            widget.CurrentLayoutIcon(
                scale=0.7,
                padding=0,
                background=colors[1]
            ),
            widget.CurrentLayout(
                font="Source Code Pro bold",
                fontsize=12,
                background=colors[1],
                foreground=colors[9]
            ),
            sep,
            space,
            widget.WindowCount(
                show_zero=True,
                font="Source Code Pro Bold",
                fontsize=14,
                padding=0,
                foreground=colors[3],
                background=colors[1]
            ),
            space, 
            sep,
            widget.TaskList(
                icon_size=0,
                foreground=colors[2],
                background=colors[1],
                borderwidth=2,
                border=colors[7],
                margin=0,
                padding=6,
                highlight_method="block",
                title_width_method="uniform",
                urgent_alert_method="border",
                urgent_border=colors[3],
                rounded=False,
                txt_floating=" ",
                txt_maximized=" ",
                txt_minimized=" "
            ),
            sep,
            #widget.WindowName(
            #    format='{state}{name}',
            #    max_chars=66,
            #    background=colors[1]
            #),
            #widget.Spacer(
            #    length=bar.STRETCH,
            #    background=colors[1]
            #),
            #nerd_icon(
            #    "",
            #    colors[7]
            #),
            #widget.Battery(
            #    foreground=colors[7],
            #    background=colors[1],
            #    format="{percent:2.0%}",
            #    mouse_callbacks={
            #        'Button1': lambda: qtile.cmd_spawn("alacritty -e battop")
            #    }
            space,
            nerd_icon(
                "",
                colors[8]
            ),

            ###################################
            # SETTING FOR OLD LENOVO NOTEBOOK #
            ###################################

            #widget.Backlight(
            #    backlight_name='acpi_video0',
            #    brightness_file='/sys/class/backlight/acpi_video0/brightness',
            #    max_brightness_file='/sys/class/backlight/acpi_video0/max_brightness',
            #    change_command='blight set {:.0f}',
            #    background=colors[1],
            #    foreground=colors[8]
            #),
            widget.Backlight(
                backlight_name='radeon_bl0',
                brightness_file='/sys/class/backlight/radeon_bl0/brightness',
                max_brightness_file='/sys/class/backlight/radeon_bl0/max_brightness',
                change_command='blight set {:.0f}',
                background=colors[1],
                foreground=colors[8]
            ),
            space,
            nerd_icon(
                "墳",
                colors[6]
            ),
            widget.Volume(
                step=5,
                foreground=colors[6],
                background=colors[1],
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("{terminal} -e pulsemixer")
                }
            ),
            space,
            #space,
            #nerd_icon(
            #    "",
            #    colors[6]
            #),
            #widget.ThermalZone(
            #    crit=90,
            #    fgcolor_crit=colors[3],
            #    format_crit="{temp}°C",
            #    fgcolor_high=colors[6],
            #    fgcolor_normal=colors[2],
            #    foreground=colors[2],
            #    background=colors[1]
            #),
            nerd_icon(
                "",
                colors[3]
            ),
            widget.CPU(
                format="{load_percent}%",
                foreground=colors[3],
                background=colors[1],
                update_interval=1,
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("{terminal} -e gotop")
                }
            ),
            space,
            nerd_icon(
                "﬙",
                colors[4]
            ),
            widget.Memory(
                format="{MemUsed:.0f}{mm}",
                foreground=colors[4],
                background=colors[1],
                update_interval=1,
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("{terminal} -e gotop")
                }
            ),
            space,
            #space,
            #nerd_icon(
            #    "",
            #    colors[7]
            #),
            #widget.GenPollText(
            #    foreground=colors[7],
            #    background=colors[1],
            #    update_interval=1,
            #    func=lambda: storage.diskspace('FreeSpace'),
            #    mouse_callbacks={
            #        'Button1': lambda: qtile.cmd_spawn("alacritty -e ncdu")
            #    }
            #),
            #space,
            #nerd_icon(
            #    "",
            #    colors[4]
            #),
            #widget.GenPollText(
            #    foreground=colors[2],
            #    background=colors[1],
            #    update_interval=5,
            #    func= lambda: subprocess.check_output("/home/thinker/.config/qtile/scripts/num-installed-pkgs").decode("utf-8"),
            #),
            #space,

            # Left Side of the bar

            #widget.Spacer(
            #    length=bar.STRETCH,
            #    background=colors[1]
            #),
            #nerd_icon(
            #    "",
            #    colors[4]
            #),
            #    format="{down} ↓↑ {up}",
            #    foreground=colors[4],
            #    background=colors[1],
            #    update_interval=0.5,
            #    mouse_callbacks={
            #        'Button1': lambda: qtile.cmd_spawn("alacritty -e gotop")
            #    }
            sep,
            nerd_icon(
                "",
                colors[4]
            ),
            widget.CheckUpdates(
                no_update_string='0',
                update_interval=600,
                distro="Arch_paru",
                display_format="{updates}",
                background=colors[1],
                foreground=colors[2],
            ),
            sep,
            nerd_icon(
                "",
                colors[9]
            ),
            widget.Clock(
                format='%A',
                foreground=colors[9],
                background=colors[1]
            ),
            widget.Clock(
                format='%H:%M:%S',
                font="Source Code Pro bold",
                foreground=colors[6],
                background=colors[1]
            ),
            widget.Clock(
                format='%d.%m.%y',
                foreground=colors[9],
                background=colors[1]
            ),
            sep,
            widget.KeyboardLayout(
                font="Source Code Pro bold",
                foreground=colors[6],
                background=colors[1]
            ),
            sep,
            widget.Systray(
                icon_size=20,
                background=colors[1]
            ),
            space,
        ]
    return widgets_list


# screens/bar
def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_list(), size=26, opacity=1.0, margin=[0,0,0,0]))]


screens = init_screens()


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='Viewnior'),  # Photos/Viewnior 
    Match(wm_class='ImageMagick'),  # ImageMagick
    Match(wm_class='Display'),  # ImageMagick
    Match(wm_class='Alafloat'),  # Floating Alacritty Terminal 
    Match(title='About Mozilla Thunderbird'),  # About Thunderbird
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='feh'),  # Feh
], **layout_theme)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
