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
from libqtile.config import Key, KeyChord, Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
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
    Key([], "XF86MonBrightnessUp", lazy.spawn("blight set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("blight set -5%")),

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

    # Rofi helpers

    KeyChord([mod], "r", [
        Key([], "r", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/launcher.sh"), desc="Open Rofi"),
        Key([], "b", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/launcher_bin.sh"), desc="Open Rofi"),
        Key([], "p", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/powermenu.sh"), desc="Open Rofi Powermenu"),
        Key([], "w", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/rofi-wiki.sh"), desc="Open Rofi Arch-wiki"),
        Key([], "n", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/rofi-network-manager.sh"), desc="Open Rofi Network Manager"),
        Key([], "c", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/rofi-calc.sh"), desc="Open Rofi Calculator"),
        Key([], "d", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/rofi-configs.sh"), desc="Open Quick Configs Edits"),
        Key([], "e", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/rofi-emoji.sh"), desc="Open Rofi Emoji menu"),
        Key([], "q", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/quicklinks.sh"), desc="Open Rofi Quicklinks"),
        Key([], "s", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/screenshot.sh"), desc="Open Rofi Screenshot utillity"),
        Key([], "m", lazy.spawn("/home/oizero/.config/rofi/qtile/bin/wm-changer.sh"), desc="Open WM changer"),
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

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

group_labels = ["TERM", "WEB", "FILE", "DRAW", "MUSC", "DEV", "VIRT", "CHAT", "MAIL", "PLAY"]

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
                'border_focus': "8be9fd",
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

# SCRATCHPAD
groups.append(ScratchPad('scratchpad', [
    DropDown('term', 'alacritty', width=0.4, height=0.5, x=0.3, y=0.2, opacity=1),
]))

keys.extend([
    Key(["control"], "1", lazy.group['scratchpad'].dropdown_toggle('term'))
])


def init_colors():
    return [["#282a36", "#282a36"],  # color 0  | bg
            ["#f8f8f2", "#f8f8f2"],  # color 1  | fg
            ["#ff5555", "#ff5555"],  # color 2  | red
            ["#50fa7b", "#50fa7b"],  # color 3  | green
            ["#f1fa8c", "#f1fa8c"],  # color 4  | yellow
            ["#ffb86c", "#ffb86c"],  # color 5  | orange
            ["#bd93f9", "#bd93f9"],  # color 6  | magenta
            ["#ff79c6", "#ff79c6"],  # color 7  | pink
            ["#8be9fd", "#8be9fd"],  # color 8  | cyan
            ["#bbbbbb", "#bbbbbb"]]  # color 9  | white


def init_separator():
    return widget.Sep(
                size_percent=60,
                margin=5,
                linewidth=2,
                background=colors[0],
                foreground="#555555")


def nerd_icon(nerdfont_icon, fg_color):
    return widget.TextBox(
                font="Iosevka Nerd Font",
                fontsize=15,
                text=nerdfont_icon,
                foreground=fg_color,
                background=colors[0])


def init_edge_spacer():
    return widget.Spacer(
                length=4,
                background=colors[0])


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
            widget.Spacer(
                length=1,
                background=colors[0]
            ),
            widget.Image(
                filename="~/.config/qtile/python.png",
                background=colors[0],
                foreground=colors[1],
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn(
                        f'{terminal} -e nvim /home/oizero/.config/qtile/config.py'
                    ),
                    'Button3': lambda: qtile.cmd_spawn(
                        f'{terminal} -e nvim /home/oizero/.config/qtile/autostart.sh'
                    )
                }
            ),
            widget.GroupBox(
                #font="Iosevka Nerd Font",
                font="Source Code Pro Bold",
                fontsize=10,
                margin_y=4,
                margin_x=4,
                padding_y=5,
                padding_x=5,
                forground=colors[1],
                background=colors[0],
                borderwidth=2,
                disable_drag=True,
                highlight_method="line",
                highlight_color=['282a36'],
                this_screen_border=colors[3],
                this_current_screen_border=colors[6],
                active=colors[6],
                inactive=colors[1],
                rounded=False,
                use_mouse_wheel=False
            ),
            sep,
            widget.CurrentLayoutIcon(
                scale=0.7,
                padding=0,
                background=colors[0]
            ),
            widget.CurrentLayout(
                font="Source Code Pro bold",
                fontsize=12,
                background=colors[0],
                foreground=colors[8]
            ),
            sep,
            space,
            widget.WindowCount(
                show_zero=True,
                font="Source Code Pro Bold",
                fontsize=14,
                padding=0,
                foreground=colors[2],
                background=colors[0]
            ),
            space, 
            sep,
            widget.TaskList(
                icon_size=0,
                foreground=colors[1],
                background=colors[0],
                borderwidth=2,
                border=colors[6],
                margin=0,
                padding=6,
                highlight_method="block",
                title_width_method="uniform",
                urgent_alert_method="border",
                urgent_border=colors[2],
                rounded=False,
                txt_floating=" ",
                txt_maximized=" ",
                txt_minimized=" "
            ),
            sep,
            space,
            nerd_icon(
                " ",
                colors[7]
            ),

            ###################################
            # SETTING FOR OLD LENOVO NOTEBOOK #
            ###################################

            #widget.Backlight(
            #    backlight_name='acpi_video0',
            #    brightness_file='/sys/class/backlight/acpi_video0/brightness',
            #    max_brightness_file='/sys/class/backlight/acpi_video0/max_brightness',
            #    change_command='blight set {:.0f}',
            #    background=colors[0],
            #    foreground=colors[7]
            #),
            widget.Backlight(
                backlight_name='radeon_bl0',
                brightness_file='/sys/class/backlight/radeon_bl0/brightness',
                max_brightness_file='/sys/class/backlight/radeon_bl0/max_brightness',
                change_command='blight set {:.0f}',
                background=colors[0],
                foreground=colors[7]
            ),
            space,
            nerd_icon(
                "墳",
                colors[5]
            ),
            widget.Volume(
                step=5,
                foreground=colors[5],
                background=colors[0],
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("{terminal} -e pulsemixer")
                }
            ),
            space,
            nerd_icon(
                "",
                colors[2]
            ),
            widget.CPU(
                format="{load_percent}%",
                foreground=colors[2],
                background=colors[0],
                update_interval=1,
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("{terminal} -e gotop")
                }
            ),
            space,
            nerd_icon(
                "﬙",
                colors[3]
            ),
            widget.Memory(
                format="{MemUsed:.0f}{mm}",
                foreground=colors[3],
                background=colors[0],
                update_interval=1,
                mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("{terminal} -e gotop")
                }
            ),
            sep,
            nerd_icon(
                " ",
                colors[3]
            ),
            widget.CheckUpdates(
                no_update_string='0',
                update_interval=600,
                distro="Arch_checkupdates",
                display_format="{updates}",
                background=colors[0],
                foreground=colors[1],
            ),
            sep,
            nerd_icon(
                " ",
                colors[8]
            ),
            widget.Clock(
                format='%A',
                foreground=colors[8],
                background=colors[0]
            ),
            widget.Clock(
                format='%H:%M:%S',
                font="Source Code Pro bold",
                foreground=colors[5],
                background=colors[0]
            ),
            widget.Clock(
                format='%d.%m.%y',
                foreground=colors[8],
                background=colors[0]
            ),
            sep,
            widget.KeyboardLayout(
                font="Source Code Pro bold",
                foreground=colors[5],
                background=colors[0]
            ),
            sep,
            widget.Systray(
                icon_size=20,
                background=colors[0]
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
    Match(title='feh [1 of 1] - /home/oizero/Screenshots/Rozvrch_9.B.png'), # Feh 
    Match(title='pinentry'),  # GPG key password entry
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
