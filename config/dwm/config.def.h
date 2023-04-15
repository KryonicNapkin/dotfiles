/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

#define SESSION_FILE "/tmp/dwm-session"
#define ROFIDIR "/home/oizero/.config/rofi/dwm/bin/"
#define WORKDIR "/home/oizero/.config/dwm/"
#define CONFDIR "/home/oizero/.config/"
#define SCRIPTD "/home/oizero/.local/bin/"
#define HOMEDIR "/home/oizero/"

/* appearance */
static const unsigned int borderpx       = 1;        /* border pixel of windows */
static const unsigned int snap           = 0;        /* snap pixel */
static const int swallowfloating         = 0;        /* 1 means swallow floating windows by default*/
static const int showbar                 = 1;        /* 0 means no bar */
static const int topbar                  = 1;        /* 0 means bottom bar */
static const int user_bh                 = 5;        /* 2 is the default spacing around the bar's font */
static const unsigned int systraypinning = 0;        /* 0: sloppy systray follows selected monitor, > 0: pin systray to monitor X*/
static const unsigned int systrayonleft  = 0;        /* 0: systray in the right corner, >0: systray on left of status text*/
static const unsigned int systrayspacing = 2;        /* systray spacing */
static const int systraypinningfailfirst = 1;        /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor */
static const int showsystray             = 1;        /* 0 means no systray */
static const char *fonts[]               = { "sans:size=8" };
static const char dmenufont[]            = "sans:size=8";
static const char col_black[]            = "#000000";
static const char col_gray1[]            = "#282C34";
static const char col_gray2[]            = "#444444";
static const char col_gray3[]            = "#ABB2BF";
static const char col_gray4[]            = "#eeeeee";
static const char col_cyan[]             = "#61AFEF";
static const char col_red[]              = "#E06C75";
static const char *colors[][3]           = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeStatus]  = { col_gray3, col_gray1,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { col_gray4, col_cyan,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm]  = { col_gray3, col_gray1,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]  = { col_black, col_cyan,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]  = { col_gray3, col_gray1,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {"alacritty", "--class", "sphtop", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.yml", "-e", "htop", NULL };
const char *spcmd2[] = {"alacritty", "--class", "spterm", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.yml", NULL };
const char *spcmd3[] = {"alacritty", "--class", "sptime", "--config-file", CONFDIR "alacritty/alacritty_scratchpad.yml", "-e", "tty-clock", "-s", "-b", "-c", "-f", "%a %d.%m.%y", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"sphtop",      spcmd1},
	{"spterm",      spcmd2},
	{"sptime",      spcmd3},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance          title       tags mask   isfloating      isterminal    noswallow      monitor */
	{ NULL,        NULL,		    "Screen Layout Editor",   		0,	    	  1,             0,            0,		      -1 },
	{ "Tlp-UI",    NULL,			NULL,		0,	    		1,            0,             0,		      -1 },
	{ "discord",   NULL,			NULL,		1 << 8,			0,            0,             0,		      -1 },
	{ "feh",       NULL,			NULL,		0,	    		1,            0,             0,		      -1 },
	{ "Gimp",	   NULL,			NULL,		0,				0,            0,             0,		      -1 },
	{ "Firefox",   NULL,			NULL,		1 << 2,			0,			  0,            -1,           -1 },
	{ "Alacritty", NULL,			NULL,		0,			    0,			  1,             0,           -1 },
	{ NULL,        NULL,	    "Event Tester",	0,			    0,			  1,            -1,           -1 }, /* xev */
	{ NULL,		  "sphtop",		    NULL,		SPTAG(0),		1,			 -1 },
	{ NULL,		  "spterm",		    NULL,		SPTAG(1),		1,			 -1 },
	{ NULL,		  "sptime",		    NULL,		SPTAG(2),		1,			 -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#include "gaplessgrid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "###",      gaplessgrid },
	{ NULL,       NULL },
};

/* key definitions */
#define ALTKEY Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	&((Keychord){1, {{MODKEY, KEY}},                            view,                   {.ui = 1 << TAG} }), \
	    &((Keychord){1, {{MODKEY|ControlMask, KEY}},            toggleview,             {.ui = 1 << TAG} }), \
	    &((Keychord){1, {{MODKEY|ShiftMask, KEY}},              tag,                    {.ui = 1 << TAG} }), \
	    &((Keychord){1, {{MODKEY|ControlMask|ShiftMask, KEY}},  toggletag,              {.ui = 1 << TAG} }),

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR "slbar"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]     = { ROFIDIR "launcher.sh", NULL };
static const char *miccmd[]       = { "amixer", "-q", "set", "Capture", "toggle", NULL };
static const char *updates[]      = { SCRIPTD "updates.sh", NULL };
static const char *rofiwmc[]      = { ROFIDIR "wm-changer.sh", NULL };
static const char *rofipow[]      = { ROFIDIR "powermenu.sh", NULL };
static const char *rofibin[]      = { ROFIDIR "launcher_bin.sh", NULL };
static const char *roficnf[]      = { ROFIDIR "rofi-configs.sh", NULL };
static const char *rofiemj[]      = { ROFIDIR "rofi-emoji.sh", NULL };
static const char *rofiscr[]      = { ROFIDIR "screenshot.sh", NULL };
static const char *roficlc[]      = { ROFIDIR "rofi-calc.sh", NULL };
static const char *rofintw[]      = { ROFIDIR "rofi-network-manager.sh", NULL };
static const char *rofiqkl[]      = { ROFIDIR "quicklinks.sh", NULL };
static const char *rofiwik[]      = { ROFIDIR "rofi-wiki.sh", NULL };
static const char *browser[]      = { "brave", NULL };
static const char *filebrw[]      = { "pcmanfm", NULL };
static const char *termcmd[]      = { "alacritty", NULL };
static const char *inkscape[]     = { "inkscape", NULL };
static const char *dispplan[]     = { "feh", HOMEDIR "Screenshots/Rozvrch_9.B.png", NULL };
static const char *xpropinfo[]    = { SCRIPTD "xprop_info.sh", NULL };
static const char *dunstclose[]   = { SCRIPTD "dunst_close.sh", NULL };

// Definition of keybindings
static Keychord *keychords[] = {
	/* Keys         function               argument */
	&((Keychord){1, {{0, XF86XK_AudioMute}},            spawn,          SHCMD("amixer -q set 'Master' toggle; kill -44 $(pidof slbar)")}),
	&((Keychord){1, {{0, XF86XK_AudioLowerVolume}},     spawn,          SHCMD("amixer -q set Master 5%- unmute; kill -44 $(pidof slbar)")}),
	&((Keychord){1, {{0, XF86XK_AudioRaiseVolume}},     spawn,          SHCMD("amixer -q set Master 5%+ unmute; kill -44 $(pidof slbar)")}),
	&((Keychord){1, {{0, XF86XK_AudioMicMute}},         spawn,          {.v = miccmd } }),
	&((Keychord){1, {{0, XF86XK_MonBrightnessUp}},      spawn,          SHCMD("blight set +5%; kill -45 $(pidof slbar)")}),
	&((Keychord){1, {{0, XF86XK_MonBrightnessDown}},    spawn,          SHCMD("blight set -5%; kill -45 $(pidof slbar)")}),
	&((Keychord){1, {{MODKEY|ALTKEY, XK_u}},            spawn,          {.v = updates } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_r}},        spawn,          {.v = dmenucmd } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_p}},	    spawn,          {.v = rofipow } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_b}},	    spawn,          {.v = rofibin } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_d}},	    spawn,          {.v = roficnf } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_e}},	    spawn,          {.v = rofiemj } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_s}},	    spawn,          {.v = rofiscr } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_c}},	    spawn,          {.v = roficlc } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_n}},	    spawn,          {.v = rofintw } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_q}},	    spawn,          {.v = rofiqkl } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_w}},	    spawn,          {.v = rofiwik } }),
	&((Keychord){2, {{MODKEY, XK_r}, {0, XK_m}},	    spawn,          {.v = rofiwmc } }),
	&((Keychord){1, {{MODKEY, XK_Return}},			    spawn,          {.v = termcmd } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_w}},	        spawn,          {.v = browser } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_i}},		    spawn,          {.v = inkscape } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_f}},		    spawn,          {.v = filebrw } }),
	&((Keychord){1, {{ALTKEY|ControlMask, XK_r}},		spawn,          {.v = dispplan } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_c}},	    	spawn,          {.v = dunstclose } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_x}},   		spawn,          {.v = xpropinfo } }),
	&((Keychord){1, {{ALTKEY, XK_space}},         		spawn,          SHCMD("setxkbmap -option 'grp:alt_space_toggle' -layout 'us,sk'; kill -46 $(pidof slbar)")}),
	&((Keychord){1, {{MODKEY, XK_b}},				    togglebar,      {0} }),
	&((Keychord){1, {{MODKEY, XK_f}},				    togglefullscr,  {0} }),
	&((Keychord){1, {{MODKEY, XK_i}},				    incnmaster,     {.i = +1 } }),
	&((Keychord){1, {{MODKEY, XK_d}},				    incnmaster,     {.i = -1 } }),
	&((Keychord){1, {{MODKEY, XK_h}},				    focusdir,       {.i =  0} }), // left
	&((Keychord){1, {{MODKEY, XK_l}},				    focusdir,       {.i =  1} }), // right
	&((Keychord){1, {{MODKEY, XK_k}},				    focusdir,       {.i =  2} }), // up
	&((Keychord){1, {{MODKEY, XK_j}},				    focusdir,       {.i =  3} }), // down
	&((Keychord){1, {{MODKEY|ShiftMask, XK_h}},		    placedir,       {.i =  0} }), // left
	&((Keychord){1, {{MODKEY|ShiftMask, XK_l}},		    placedir,       {.i =  1} }), // right
	&((Keychord){1, {{MODKEY|ShiftMask, XK_k}},		    placedir,       {.i =  2} }), // up
	&((Keychord){1, {{MODKEY|ShiftMask, XK_j}},		    placedir,       {.i =  3} }), // down
	&((Keychord){1, {{MODKEY|ControlMask, XK_h}},	    setmfact,       {.f = -0.01 } }),
	&((Keychord){1, {{MODKEY|ControlMask, XK_l}},	    setmfact,       {.f = +0.01} }),
	&((Keychord){1, {{MODKEY|ControlMask, XK_j}},	    setcfact,       {.f = -0.10} }),
	&((Keychord){1, {{MODKEY|ControlMask, XK_k}},	    setcfact,       {.f = +0.10} }),
	&((Keychord){1, {{MODKEY|ControlMask, XK_o}},	    setcfact,       {.f =  0.00} }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_Return}},    zoom,           {0} }),
	&((Keychord){1, {{MODKEY, XK_Tab}},				    view,           {0} }),
	&((Keychord){1, {{MODKEY, XK_c}},       		    killclient,     {0} }),
	&((Keychord){1, {{MODKEY, XK_space}},				cyclelayout,    {.i = +1} }),
	&((Keychord){1, {{MODKEY|ControlMask, XK_f}}, 	    togglefloating, {0} }),
	&((Keychord){1, {{MODKEY, XK_comma}},			    focusmon,       {.i = -1 } }),
	&((Keychord){1, {{MODKEY, XK_period}},			    focusmon,       {.i = +1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_comma}},	    tagmon,         {.i = -1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_period}},	tagmon,         {.i = +1 } }),
	&((Keychord){1, {{MODKEY|ALTKEY, XK_l}},	        movekeyboard_x, {.i = 20 } }),
	&((Keychord){1, {{MODKEY|ALTKEY, XK_h}},	        movekeyboard_x, {.i = -20 } }),
	&((Keychord){1, {{MODKEY|ALTKEY, XK_k}},	        movekeyboard_y, {.i = 20 } }),
	&((Keychord){1, {{MODKEY|ALTKEY, XK_j}},	        movekeyboard_y, {.i = -20 } }),
	&((Keychord){1, {{ALTKEY, XK_1}},           	    togglescratch,  {.ui = 0} }),
	&((Keychord){1, {{ALTKEY, XK_2}},				    togglescratch,  {.ui = 1} }),
	&((Keychord){1, {{ALTKEY, XK_3}},				    togglescratch,  {.ui = 2} }),
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        XK_0,                      9)
	&((Keychord){1, {{ MODKEY|ControlMask, XK_q}},      quit,           {0} }),
    &((Keychord){1, {{ MODKEY|ControlMask, XK_r}},      quit,           {1} }),
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1 } },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2 } },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3 } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};