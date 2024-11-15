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
from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.dgroups import simple_key_binder
from libqtile.utils import send_notification
from libqtile.config import Key, KeyChord, Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile import widget
from libqtile.widget import base

# Constants definition
HOMEDIR = os.environ.get('HOME')
SCRIPTD = os.path.expanduser("{}/.local/bin/scripts/".format(HOMEDIR))
UTILD = os.path.expanduser("{}/.local/bin/utils/".format(HOMEDIR))
WORKDIR = os.path.expanduser("{}/.config/qtile/".format(HOMEDIR))
CONFDIR = os.path.expanduser("{}/.config/".format(HOMEDIR))

# Keys definition
mod = "mod4"
alt = "mod1"

# Variables definition
terminal = "alacritty"
browser = os.environ.get('BROWSER')
steam = "steam"
thndbird = "thunderbird"
inkscape = "inkscape"
rssreader = "newsflash"
filebrw = "thunar"
discord = "discord"
kdeconnect = "kdeconnect-app"
virtmngr = "virt-manager"
hptoolbox = "hp-toolbox"
superproductivity = "superproductivity"
dispplan = "feh {}/Pictures/Screenshots/rozvrch_II_E.png".format(HOMEDIR)
updates = "{}misc/updates.sh".format(SCRIPTD)
restartprocs = "{}prep.sh".format(SCRIPTD)
mutemic = "{}misc/mice-mute.sh".format(SCRIPTD)
dunstclose = "{}misc/dunst-close.sh".format(SCRIPTD)

# Hooks

@hook.subscribe.client_new
def new_client(client):
    if client.name == 'Mozilla Thunderbird':
        client.togroup('8')

@hook.subscribe.client_new
def new_client(client):
    if client.name == 'Discord':
        client.togroup('9')

@hook.subscribe.client_new
def new_client(client):
    if client.name == 'Steam':
        client.togroup('0')

@hook.subscribe.client_killed
def client_killed(client):
    send_notification("qtile", f"{client.name} has been killed")

keys = [
    # WINDOWS MANAGMENT
    # Window navigation
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

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
    Key([mod, "control"], "h",
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
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    # window state modifing
    Key([mod, "control"], "f", lazy.window.toggle_floating(), desc="Toggle floating mode"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreeen"),
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
    Key([alt], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),

    # Audio and brightness control
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")), 
    Key([], "XF86AudioStop", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
    Key([], "XF86AudioMicMute", lazy.spawn(mutemic)),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("blight set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("blight set -5%")),

    # Used apps
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch Alacritty"),
    Key([mod, "shift"], "w", lazy.spawn(browser), desc="Open Brave"),
    Key([mod, "shift"], "f", lazy.spawn(filebrw), desc="Open PCManFM"),
    Key([mod, "shift"], "i", lazy.spawn(inkscape), desc="Open Inkscape"),
    Key([mod, "shift"], "s", lazy.spawn(steam), desc="Open Steam"),
    Key([mod, "shift"], "v", lazy.spawn(virtmngr), desc="Open Virt-manager"),
    Key([mod, "shift"], "d", lazy.spawn(discord), desc="Open Discord"),
    Key([mod, "shift"], "t", lazy.spawn(thndbird), desc="Open Thunderbird"),
    Key([mod, "shift"], "r", lazy.spawn(rssreader), desc="Open Newsflash"),
    Key([mod, "shift"], "p", lazy.spawn(hptoolbox), desc="Open HP Toolbox"),
    Key([mod, "shift"], "k", lazy.spawn(kdeconnect), desc="Open KDE Connect app"),
    Key([mod, "shift"], "c", lazy.spawn(superproductivity), desc="Open SuperProductivity app"),

    Key([alt, "control"], "r", lazy.spawn(dispplan), desc="Display rozvrch"), 

    # Notification apps
    Key([mod, alt], "u", lazy.spawn(updates), desc="List updates"),
    Key([mod, alt], "c", lazy.spawn(dunstclose), desc="Close dunst notification"),
    Key([mod, alt], "m", lazy.spawn(mutemic), desc="Mute microphone"),

    # dmenu keybindings
    KeyChord([mod], "r", [
        Key([], "a", lazy.spawn("{}dm-avr_code.sh".format(SCRIPTD)), desc="Open Arduino sketches menu"),
        Key([], "r", lazy.spawn("{}dm-run.sh".format(SCRIPTD)), desc="Open Dmenu"),
        Key([], "b", lazy.spawn("{}dm-bin.sh".format(SCRIPTD)), desc="Open dmenu (/bin dir)"),
        Key([], "p", lazy.spawn("{}dm-pwr.sh".format(SCRIPTD)), desc="Open dmenu Powermenu"),
        Key([], "w", lazy.spawn("{}dm-wiki.sh".format(SCRIPTD)), desc="Open dmenu Arch-wiki"),
        Key([], "c", lazy.spawn("{}dm-clip.sh".format(SCRIPTD)), desc="Open dmenu clipmenu"),
        Key([], "d", lazy.spawn("{}dm-win.sh".format(SCRIPTD)), desc="Open list of opened windows"),
        Key([], "i", lazy.spawn("{}dm-pkginf.sh".format(SCRIPTD)), desc="Open Package info menu"),
        Key([], "e", lazy.spawn("{}dm-dots.sh".format(SCRIPTD)), desc="Open Configs Edits"),
        Key([], "q", lazy.spawn("{}dm-qkl.sh".format(SCRIPTD)), desc="Open dmenu Quicklinks"),
        Key([], "s", lazy.spawn("{}dm-scrt.sh".format(SCRIPTD)), desc="Open dmenu Screenshot utillity"),
        Key([], "m", lazy.spawn("{}dm-man.sh".format(SCRIPTD)), desc="Open manpages menu"),
        Key([], "k", lazy.spawn("{}dm-scpwiki.sh".format(SCRIPTD)), desc="Open SCP wiki entries list"),
        Key([], "v", lazy.spawn("{}dm-vms.sh".format(SCRIPTD)), desc="Open dmenu's VMs manager"),
    ]),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),

    # Qtile restart and quit Qtile
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "t", lazy.spawn(restartprocs), desc="Reload prep.sh"),
]

# My workspaces

# Create labels for groups and assign them a default layout.
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

group_layouts = ["monadtall", "monadtall", "monadtall",  "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
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
                'margin': 0,
                'single_border_width': 0,
                'border_focus': "#61AFEF",
                'border_normal': "#373B41",
                }

layouts = [
    layout.MonadTall(**layout_theme, max_ratio=0.95, min_ratio=0.05, change_ratio=0.05),
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
]

def init_colors():
    return [["#282C34", "#282C34"],  # color 0  | bg
            ["#FFFFFF", "#FFFFFF"],  # color 1  | fg
            ["#000000", "#000000"],  # color 2  | black
            ["#E06C75", "#E06C75"],  # color 3  | red
            ["#98C379", "#98C379"],  # color 4  | green
            ["#E5C07B", "#E5C07B"],  # color 5  | yellow
            ["#C678DD", "#C678DD"],  # color 6  | magenta
            ["#61AFEF", "#61AFEF"],  # color 7  | blue
            ["#56B6C2", "#56B6C2"],  # color 8  | cyan
            ["#ABB2BF", "#ABB2BF"]]  # color 9  | white

def init_separator():
    return widget.Sep(
                size_percent=60,
                margin=5,
                linewidth=2,
                background=colors[0],
                foreground="#373B41")

def nerd_icon(nerdfont_icon, fg_color):
    return widget.TextBox(
                font="Iosevka Nerd Font",
                fontsize=16,
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
    font="JetBrainsMonoNL",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
            widget.GroupBox(
                margin_y=3,
                margin_x=0,
                padding_x=8,
                forground=colors[9],
                background=colors[0],
                borderwidth=2,
                disable_drag=True,
                highlight_method="block",
                this_current_screen_border=colors[7],
                block_highlight_text_color=colors[2],
                active=colors[1],
                inactive=colors[9],
                rounded=False,
                use_mouse_wheel=False,
                urgent_alert_method="block",
                urgent_border=colors[3]
            ),
            space,
            sep,
            space,
            widget.CurrentLayoutIcon(
                scale=0.9,
                padding=3,
                background=colors[0]
            ),
            space,
            sep,
            widget.TaskList(
                icon_size=None,
                markup=True,
                foreground=colors[1],
                background=colors[0],
                borderwidth=2,
                border=colors[7],
                margin=0,
                padding=3,
                highlight_method="block",
                title_width_method="uniform",
                urgent_alert_method="block",
                urgent_border=colors[3],
                window_name_location=True,
                rounded=False,
                txt_floating=" ",
                txt_maximized=" ",
                txt_minimized=" "
            ),
            sep,
            space,
            widget.TextBox(
                fmt="BAT:",
                font="JetBrainsMonoNL bold",
                foreground=colors[5],
                background=colors[0],
            ),
            widget.GenPollCommand(
                foreground=colors[5],
                background=colors[0],
                cmd="{}battu -s -c -w -n".format(UTILD),
                shell=True,
                update_interval=15,
            ),
            space,
            sep,
            space,
            widget.TextBox(
                fmt="BRG:",
                font="JetBrainsMonoNL bold",
                foreground=colors[8],
                background=colors[0],
            ),
            widget.Backlight(
                backlight_name='amdgpu_bl1',
                brightness_file='/sys/class/backlight/amdgpu_bl1/brightness',
                max_brightness_file='/sys/class/backlight/amdgpu_bl1/max_brightness',
                change_command='blight set {:.0f}',
                foreground=colors[8],
                background=colors[0],
            ),
            space,
            sep,
            space,
            widget.TextBox(
                fmt="VOL:",
                font="JetBrainsMonoNL bold",
                foreground=colors[6],
                background=colors[0],
            ),
            widget.Volume(
                step=5,
                foreground=colors[6],
                background=colors[0],
            ),
            space,
            sep,
            space,
            widget.TextBox(
                fmt="CPU:",
                font="JetBrainsMonoNL bold",
                foreground=colors[3],
                background=colors[0],
            ),
            widget.ThermalSensor(
                format='{temp:.0f}{unit}',
                foreground=colors[3],
                background=colors[0],
                update_interval=1,
            ),
            widget.CPU(
                format="{load_percent}%",
                foreground=colors[3],
                background=colors[0],
                update_interval=1,
            ),
            space,
            sep,
            space,
            widget.TextBox(
                fmt="MEM:",
                font="JetBrainsMonoNL bold",
                foreground=colors[4],
                background=colors[0],
            ),
            widget.Memory(
                format="{MemUsed:.0f}{mm}",
                foreground=colors[4],
                background=colors[0],
                update_interval=1,
            ),
            space,
            sep,
            space,
            widget.TextBox(
                fmt="SSD:",
                font="JetBrainsMonoNL bold",
                foreground=colors[9],
                background=colors[0],
            ),
            widget.DF(
                visible_on_warn=False,
                format="{uf}{m} {r:.0f}%",
                foreground=colors[9],
                background=colors[0],
            ),
            space,
            sep,
            space,
            widget.KeyboardLayout(
                font="JetBrainsMonoNL Bold",
                configured_keyboards=['us', 'sk'],
                foreground=colors[7],
                background=colors[0]
            ),
            space,
            sep,
            space,
            widget.Clock(
                format='%a',
                foreground=colors[9],
                background=colors[0]
            ),
            widget.Clock(
                format='%H:%M:%S',
                font="JetBrainsMonoNL bold",
                foreground=colors[5],
                background=colors[0]
            ),
            widget.Clock(
                format='%d.%m.%y',
                foreground=colors[9],
                background=colors[0]
            ),
            space,
            sep,
            widget.Systray(
                icon_size=24,
                background=colors[0]
            ),
            space
        ]
    return widgets_list


# screens/bar
def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_list(), size=28, opacity=1.0, margin=[0,0,0,0]))]


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
    Match(wm_class='qalculate-gtk'),  # Floating Alacritty Terminal
    Match(title='KDE Connect'), # KDE Connect app
    Match(title='test'), # Testing raylib.h simple to use graphics library
    Match(title='About Mozilla Thunderbird'),  # About Thunderbird
    Match(title='feh [1 of 1] - {}/Pictures/Screenshots/rozvrch_II_E.png'.format(HOMEDIR)), # Feh
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

# SCRATCHPADS
groups.append(ScratchPad('scratchpad0', [
    DropDown('term', "alacritty --config-file={}alacritty/alacritty_scratchpad.toml".format(CONFDIR), width=0.385, height=0.45, x=0.31, y=0.25, opacity=1, on_focus_lost_hide=False),
]))
groups.append(ScratchPad('scratchpad1', [
    DropDown('htop', "alacritty --config-file={}alacritty/alacritty_scratchpad.toml -e htop".format(CONFDIR), width=0.385, height=0.45, x=0.31, y=0.25, opacity=1, on_focus_lost_hide=False),
]))
groups.append(ScratchPad('scratchpad2', [
    DropDown('ttyc', "alacritty --config-file={}alacritty/alacritty_scratchpad.toml -e tty-clock -s -b -c -f '%a.%d.%m.%y'".format(CONFDIR), width=0.385, height=0.45, x=0.31, y=0.25, opacity=1, on_focus_lost_hide=False),
]))
groups.append(ScratchPad('scratchpad3', [
    DropDown('battop', "alacritty --config-file={}alacritty/alacritty_scratchpad.toml -e battop".format(CONFDIR), width=0.385, height=0.45, x=0.31, y=0.25, opacity=1, on_focus_lost_hide=False),
]))
groups.append(ScratchPad('scratchpad4', [
    DropDown('qalculate', "qalculate-gtk", width=0.385, height=0.45, x=0.31, y=0.25, opacity=1, on_focus_lost_hide=False),
]))

keys.extend([
    Key(["mod1"], "1", lazy.group['scratchpad0'].dropdown_toggle('term'))
])
keys.extend([
    Key(["mod1"], "2", lazy.group['scratchpad1'].dropdown_toggle('htop'))
])
keys.extend([
    Key(["mod1"], "3", lazy.group['scratchpad2'].dropdown_toggle('ttyc'))
])
keys.extend([
    Key(["mod1"], "4", lazy.group['scratchpad3'].dropdown_toggle('battop'))
])
keys.extend([
    Key(["mod1"], "5", lazy.group['scratchpad4'].dropdown_toggle('qalculate'))
])
