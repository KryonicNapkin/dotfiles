/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
#include <X11/keysym.h>

// definitons of used directories
#define SESSION_FILE "/tmp/dwm-session"
#define ROFIDIR "/home/oizero/.config/rofi/bin/"
#define WORKDIR "/home/oizero/.config/dwm/"
#define CONFDIR "/home/oizero/.config/"
#define SCRIPTD "/home/oizero/.local/bin/scripts/"
#define HOMEDIR "/home/oizero/"

// dwm appearance
static const unsigned int borderpx = 2; /* border pixel of windows */
static const unsigned int snap = 0;     /* snap pixel */
static const int swallowfloating = 0;   /* 1 means swallow floating windows by default*/
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const int user_bh = 6;           /* 2 is the default spacing around the bar's font */
static const unsigned int systraypinning = 0; /* 0: sloppy systray follows selected monitor, > 0: pin systray to monitor X*/
static const unsigned int systrayonleft = 0; /* 0: systray in the right corner, >0: systray on left of status text*/
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst = 1; /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor */
static const int showsystray = 1; /* 0 means no systray */
static const char *fonts[] = {"sans:size=8"};
// static const char dmenufont[] = "sans:size=8";

// Colors definition
static const char bg[] = "#282c34"; // normal background color
static const char wbg[] = "#373b41"; // if there were to be a widget it would use this color
static const char green[] = "#98c379";
static const char blue[] = "#61afef";
static const char yellow[] = "#e5c07b";
static const char black[] = "#000000";
static const char white[] = "#abb2bf"; // forground white
static const char fg[] = "#ffffff";    // clear white
static const char red[] = "#e06c75";
static const char pink[] = "#c678dd";
static const char cyan[] = "#56b6c2";
static const char *colors[][3] = {
    //              fg     bg   border
    [SchemeNorm] = {white, bg, wbg},
    [SchemeSel] = {fg, blue, blue},
    [SchemeStatus] = {white, bg, black}, // Statusbar right {text,background,not used but cannot be empty}
    [SchemeTagsSel] = {fg, blue, black}, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm] = {white, bg, black},  // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel] = {black, blue, black}, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm] = {white, bg, black},  // infobar middle  unselected {text,background,not used but cannot be empty}
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;
// Scratchpads
const char *spcmd1[] = {"alacritty", "--class", "spterm", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.toml", NULL};
const char *spcmd2[] = {"alacritty", "--class", "sphtop", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.toml", "-e", "htop", NULL};
const char *spcmd3[] = {"alacritty", "--class", "spttyc", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.toml", "-e", "tty-clock", "-s", "-b", "-c", "-f", "%a %d.%m.%y", NULL};
const char *spcmd4[] = {"alacritty", "--class", "spbat", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.toml", "-e", "battop", NULL};
const char *spcmd5[] = {"alacritty", "--class", "spqalc", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.yml", "-e", "qalc", NULL};
static Sp scratchpads[] = {
    // name      cmd
    {"spterm", spcmd1},
    {"sphtop", spcmd2},
    {"spttyc", spcmd3},
    {"spbat",  spcmd4},
    {"spqalc", spcmd5},
};

// Tags names
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"};
static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    // class      instance                          title               tags mask isfloating     isterminal     noswallow      monitor */
    {NULL,          NULL,                           "Screen Layout Editor", 0,      1, 0, 0, -1},
    {"discord",     NULL,                           NULL,                   1 << 8, 0, 0, 0, -1},
    {"thunderbird", NULL,                           NULL,                   1 << 7, 0, 0, 0, -1},
    {"Steam",       NULL,                           NULL,                   1 << 9, 0, 0, 0, -1},
    {"feh",         NULL,                           NULL,                   0, 1, 0, 0, -1},
    {"Gimp",        NULL,                           NULL,                   0, 0, 0, 0, -1},
    {"Inkscape",    NULL,                           NULL,                   0, 0, 0, 0, -1},
    {"Firefox",     NULL,                           NULL,                   0 << 2, 0, 0, 1, -1},
    {"Alacritty",   NULL,                           NULL,                   0, 0, 0, 0, -1},
    {NULL,          "Legacy Launcher 158.0 [AUR]",  NULL,                   0, 1, 0, 0, -1},
    {NULL,          NULL,                           "Event Tester",         0, 0, 1, 1, -1}, /* xev */
    {NULL,          "spterm",                       NULL,                   SPTAG(0), 1, 1},
    {NULL,          "sphtop",                       NULL,                   SPTAG(1), 1, 1},
    {NULL,          "spttyc",                       NULL,                   SPTAG(2), 1, 1},
    {NULL,          "spbat",                        NULL,                   SPTAG(3), 1, 1},
    {NULL,          "spqalc",                       NULL,                   SPTAG(4), 1, 1},
};

// Layout settings
static const float mfact = 0.50;     // factor of master area size [0.05..0.95]
static const int nmaster = 1;        // number of clients in master area
static const int resizehints = 1;    // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // 1 will force focus on the fullscreen window

#include "gaplessgrid.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL},
    {"[M]", monocle},
    {"###", gaplessgrid},
    {NULL, NULL}, /* no layout function means floating behavior */

};

/* key definitions */
#define ALTKEY Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG) \
    &((Keychord){1, {{MODKEY, KEY}},                        view,       {.ui = 1 << TAG}}), \
    &((Keychord){1, {{MODKEY|ControlMask, KEY}},            toggleview, {.ui = 1 << TAG}}), \
    &((Keychord){1, {{MODKEY|ShiftMask, KEY}},              tag,        {.ui = 1 << TAG}}), \
    &((Keychord){1, {{MODKEY|ControlMask|ShiftMask, KEY}},  toggletag,  {.ui = 1 << TAG}}),

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR "slbar"

// commands(variables declaration)
static char        dmenumon[2]    = "0"; // component of dmenucmd, manipulated in spawn()
static const char *dmenucmd[]     = {SCRIPTD "dm-run.sh", NULL};
static const char *dmrun[]        = {SCRIPTD "dm-run.sh", NULL};
static const char *dmwmc[]        = {SCRIPTD "dm-wmch.sh", NULL};
static const char *dmpow[]        = {SCRIPTD "dm-pwr.sh", NULL};
static const char *dmbin[]        = {SCRIPTD "dm-bin.sh", NULL};
static const char *dmwin[]        = {SCRIPTD "dm-win.sh", NULL};
static const char *dmman[]        = {SCRIPTD "dm-man.sh", NULL};
static const char *dmdots[]       = {SCRIPTD "dm-dots.sh", NULL};
static const char *dminf[]        = {SCRIPTD "dm-pkginf.sh", NULL};
static const char *dmscrt[]       = {SCRIPTD "dm-scrt.sh", NULL};
static const char *dmcpm[]        = {SCRIPTD "dm-clip.sh", NULL};
static const char *dmqkl[]        = {SCRIPTD "dm-qkl.sh", NULL};
static const char *dmscp[]        = {SCRIPTD "dm-scpwiki.sh", NULL};
static const char *dmwik[]        = {SCRIPTD "dm-wiki.sh", NULL};
static const char *rssreader[]    = {"newsflash", NULL};
static const char *virtmngr[]     = {"virt-manager", NULL};
static const char *browser[]      = {"brave", NULL};
static const char *steam[]        = {"steam", NULL};
static const char *discord[]      = {"discord", NULL};
static const char *thndbird[]     = {"thunderbird", NULL};
static const char *filebrw[]      = {"thunar", NULL};
static const char *terminal[]     = {"alacritty", NULL};
static const char *inkscape[]     = {"inkscape", NULL};
static const char *hptoolbox[]    = {"hp-toolbox", NULL};
static const char *dispplan[]     = {"feh", HOMEDIR "Pictures/Screenshots/Rozvrch_I.E.png", NULL};
static const char *updates[]      = {SCRIPTD "updates.sh", NULL};
static const char *restartprocs[] = {SCRIPTD "prep.sh", NULL};
static const char *mutemic[]      = {SCRIPTD "mice-mute.sh", NULL};
static const char *dunstclose[]   = {SCRIPTD "dunst-close.sh", NULL};
static const char *lockscreen[]   	  = {"betterlockscreen -l", NULL};

// Definition of keybindings
static Keychord *keychords[] = {
    // Keys         function                        argument      command
    // Function keys keybindings and updater of slbar
    &((Keychord){1, {{0, XF86XK_AudioPlay}},         spawn, SHCMD("playerctl play-pause")}),
    &((Keychord){1, {{0, XF86XK_AudioStop}},         spawn, SHCMD("playerctl play-pause")}),
    &((Keychord){1, {{0, XF86XK_AudioNext}},         spawn, SHCMD("playerctl next")}),
    &((Keychord){1, {{0, XF86XK_AudioPrev}},         spawn, SHCMD("playerctl previous")}),
    &((Keychord){1, {{0, XF86XK_AudioMute}},         spawn, SHCMD("pamixer -t; kill -44 $(pidof slbar)")}),
    &((Keychord){1, {{0, XF86XK_AudioLowerVolume}},  spawn, SHCMD("pamixer -d 5; kill -44 $(pidof slbar)")}),
    &((Keychord){1, {{0, XF86XK_AudioRaiseVolume}},  spawn, SHCMD("pamixer -i 5; kill -44 $(pidof slbar)")}),
    &((Keychord){1, {{0, XF86XK_MonBrightnessUp}},   spawn, SHCMD("blight set +5%; kill -45 $(pidof slbar)")}),
    &((Keychord){1, {{0, XF86XK_MonBrightnessDown}}, spawn, SHCMD("blight set -5%; kill -45 $(pidof slbar)")}),

    // Keys         function                        command  argument
    // DWM restart (procs if needed) and quit
    &((Keychord){1, {{MODKEY|ControlMask, XK_q}},    quit,  {0}}),
    &((Keychord){1, {{MODKEY|ControlMask, XK_r}},    quit,  {1}}),
    &((Keychord){1, {{MODKEY|ControlMask, XK_t}},    spawn, {.v = restartprocs}}),
    &((Keychord){1, {{MODKEY|ControlMask, XK_c}},    spawn, {.v = lockscreen}}),

    // Dmenu commands
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_r}},     spawn, {.v = dmrun}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_i}},     spawn, {.v = dminf}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_c}},     spawn, {.v = dmcpm}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_d}},     spawn, {.v = dmwin}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_p}},     spawn, {.v = dmpow}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_b}},     spawn, {.v = dmbin}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_n}},     spawn, {.v = dmman}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_e}},     spawn, {.v = dmdots}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_s}},     spawn, {.v = dmscrt}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_k}},     spawn, {.v = dmscp}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_q}},     spawn, {.v = dmqkl}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_w}},     spawn, {.v = dmwik}}),
    &((Keychord){2, {{MODKEY, XK_r}, {0, XK_m}},     spawn, {.v = dmwmc}}),

    // Notification commands
    &((Keychord){1, {{MODKEY|ALTKEY, XK_u}},         spawn, {.v = updates}}),
    &((Keychord){1, {{MODKEY|ALTKEY, XK_c}},         spawn, {.v = dunstclose}}),
    &((Keychord){1, {{0, XF86XK_AudioMicMute}},      spawn, {.v = mutemic}}),

    // Used apps
    &((Keychord){1, {{MODKEY, XK_Return}},           spawn, {.v = terminal}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_i}},      spawn, {.v = inkscape}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_p}},      spawn, {.v = hptoolbox}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_r}},      spawn, {.v = rssreader}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_w}},      spawn, {.v = browser}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_d}},      spawn, {.v = discord}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_t}},      spawn, {.v = thndbird}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_f}},      spawn, {.v = filebrw}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_s}},      spawn, {.v = steam}}),
    &((Keychord){1, {{MODKEY|ShiftMask, XK_v}},      spawn, {.v = virtmngr}}),

    // Misc
    &((Keychord){1, {{ALTKEY|ControlMask, XK_r}},    spawn, {.v = dispplan}}),

    // Keyboard layout changer
    &((Keychord){1, {{ALTKEY, XK_space}},            spawn, SHCMD("setxkbmap -option 'grp:alt_space_toggle' -layout " "'us,sk'; kill -46 $(pidof slbar)")}),

    // Window control
    &((Keychord){1, {{MODKEY, XK_h}},                focusdir, {.i = 0}}),             // left
    &((Keychord){1, {{MODKEY, XK_l}},                focusdir, {.i = 1}}),             // right
    &((Keychord){1, {{MODKEY, XK_k}},                focusdir, {.i = 2}}),             // up
    &((Keychord){1, {{MODKEY, XK_j}},                focusdir, {.i = 3}}),             // down
    &((Keychord){1, {{MODKEY|ShiftMask, XK_h}},      placedir, {.i = 0}}), // left
    &((Keychord){1, {{MODKEY|ShiftMask, XK_l}},      placedir, {.i = 1}}), // right
    &((Keychord){1, {{MODKEY|ShiftMask, XK_k}},      placedir, {.i = 2}}), // up
    &((Keychord){1, {{MODKEY|ShiftMask, XK_j}},      placedir, {.i = 3}}), // down
    &((Keychord){1, {{MODKEY|ControlMask, XK_h}},    setmfact, {.f = -0.01}}), // left
    &((Keychord){1, {{MODKEY|ControlMask, XK_l}},    setmfact, {.f = +0.01}}), // right
    &((Keychord){1, {{MODKEY|ControlMask, XK_k}},    setcfact, {.f = +0.10}}), // up
    &((Keychord){1, {{MODKEY|ControlMask, XK_j}},    setcfact, {.f = -0.10}}), // down
    &((Keychord){1, {{MODKEY, XK_c}},                killclient, {0}}), // close window

    // Floating window control
    &((Keychord){1, {{MODKEY|ControlMask, XK_f}},    togglefloating, {0}}),
    &((Keychord){1, {{MODKEY|ALTKEY, XK_h}},         movekeyboard_x, {.i = -20}}),
    &((Keychord){1, {{MODKEY|ALTKEY, XK_l}},         movekeyboard_x, {.i = 20}}),
    &((Keychord){1, {{MODKEY|ALTKEY, XK_k}},         movekeyboard_y, {.i = 20}}),
    &((Keychord){1, {{MODKEY|ALTKEY, XK_j}},         movekeyboard_y, {.i = -20}}),

    // Tags control
    TAGKEYS(XK_1, 0)
    TAGKEYS(XK_2, 1)
    TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3)
    TAGKEYS(XK_5, 4)
    TAGKEYS(XK_6, 5)
    TAGKEYS(XK_7, 6)
    TAGKEYS(XK_8, 7)
    TAGKEYS(XK_9, 8)
    TAGKEYS(XK_0, 9)
    &((Keychord){1, {{MODKEY, XK_Tab}}, view, {0}}),

    // scratchpads
    &((Keychord){1, {{ALTKEY, XK_1}},                togglescratch, {.ui = 0}}),
    &((Keychord){1, {{ALTKEY, XK_2}},                togglescratch, {.ui = 1}}),
    &((Keychord){1, {{ALTKEY, XK_3}},                togglescratch, {.ui = 2}}),
    &((Keychord){1, {{ALTKEY, XK_4}},                togglescratch, {.ui = 3}}),
    &((Keychord){1, {{ALTKEY, XK_5}},                togglescratch, {.ui = 4}}),

    // layout control
    &((Keychord){1, {{MODKEY, XK_space}},            cyclelayout, {.i = +1}}),
    &((Keychord){1, {{MODKEY, XK_f}},                togglefullscr, {0}}),
    &((Keychord){1, {{MODKEY, XK_i}},                incnmaster, {.i = +1}}),
    &((Keychord){1, {{MODKEY, XK_d}},                incnmaster, {.i = -1}}),

    // dwm bar
    &((Keychord){1, {{MODKEY, XK_b}},                togglebar, {0}}),
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    // click                event mask    button    function argument
    {ClkTagBar,     MODKEY, Button1, tag,            {0}},
    {ClkTagBar,     MODKEY, Button3, toggletag,      {0}},
    {ClkWinTitle,   0,      Button2, zoom,           {0}},
    {ClkStatusText, 0,      Button1, sigstatusbar,   {.i = 1}},
    {ClkStatusText, 0,      Button2, sigstatusbar,   {.i = 2}},
    {ClkStatusText, 0,      Button3, sigstatusbar,   {.i = 3}},
    {ClkClientWin,  MODKEY, Button1, movemouse,      {0}},
    {ClkClientWin,  MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin,  MODKEY, Button3, resizemouse,    {0}},
    {ClkTagBar,     0,      Button1, view,           {0}},
    {ClkTagBar,     0,      Button3, toggleview,     {0}},
    {ClkTagBar,     MODKEY, Button1, tag,            {0}},
    {ClkTagBar,     MODKEY, Button3, toggletag,      {0}},
};
