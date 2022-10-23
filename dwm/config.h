/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2;		  /* border pixel of windows */
static const unsigned int gappx = 5;		  /* gap pixel between windows */
static const unsigned int snap = 32;		  /* snap pixel */
static const unsigned int systraypinning = 0; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;  /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst = 1; /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray = 1;			  /* 0 means no systray */
static const int showbar = 1;				  /* 0 means no bar */
static const int topbar = 1;				  /* 0 means bottom bar */
static const char *fonts[] = {"JetBrains Mono:size=13:antialias=true:autohint=true"};
static const char dmenufont[] = "JetBrains Mono:size=15:antialias=true:autohint=true";

static char termcol0[] = "#3b4252"; /* black   */
static char termcol1[] = "#bf616a"; /* red     */
static char termcol2[] = "#a3be8c"; /* green   */
static char termcol3[] = "#ebcb8b"; /* yellow  */
static char termcol4[] = "#81a1c1"; /* blue    */
static char termcol5[] = "#b48ead"; /* magenta */
static char termcol6[] = "#88c0d0"; /* cyan    */
static char termcol7[] = "#e5e9f0"; /* white   */

static const char *colors[][3] = {
	/*               fg         bg         border   */
	[SchemeNorm] = {termcol0, termcol0, termcol0},
	[SchemeSel] = {termcol7, termcol1, termcol1},
	[SchemeHid] = {termcol0, termcol4, termcol4},
	[SchemeStatus] = {termcol4, termcol0, "#000000"},	// Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel] = {termcol7, termcol1, "#000000"},	// Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm] = {termcol7, termcol0, "#000000"}, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel] = {termcol7, termcol1, "#000000"},	// infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm] = {termcol7, termcol0, "#000000"}, // infobar middle  unselected {text,background,not used but cannot be empty}
};

static const char *const autostart[] = {
	"bash", "-c", "/home/volta/suckless/dwm/scripts/autostart.sh", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = {"", "", "", "", "", "", "", ""};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{"GoldenDict", NULL, NULL, 0, 1, -1},
	{"Wine", NULL, NULL, 0, 1, -1},
	{"wemeetapp", NULL, NULL, 0, 1, -1},
	{"zoom", NULL, NULL, 0, 1, -1},
	{"Microsoft-edge-dev", NULL, NULL, 1, 0, -1},
	{"firefox", NULL, NULL, 1, 0, -1},
	{"Google-chrome", NULL, NULL, 1, 0, -1},
	{"Chromium", NULL, NULL, 1, 0, -1},
	{"wpp", NULL, NULL, 1 << 1, 0, -1},
	{"wps", NULL, NULL, 1 << 1, 0, -1},
	{"pdf", NULL, NULL, 1 << 1, 0, -1},
	{"et", NULL, NULL, 1 << 1, 0, -1},
	{"Foxit Reader", NULL, NULL, 1 << 1, 0, -1},
	{"Code", NULL, NULL, 1 << 2, 0, -1},
	{"VSCodium", NULL, NULL, 1 << 2, 0, -1},
	{"jetbrains-studio", NULL, NULL, 1 << 2, 0, -1},
	{"jetbrains-idea", NULL, NULL, 1 << 2, 0, -1},
	{"Pcmanfm", NULL, NULL, 1 << 3, 0, -1},
	{"Gimp-2.10", NULL, NULL, 1 << 4, 0, -1},
	{"vlc", NULL, NULL, 1 << 5, 0, -1},
	{"bomi", NULL, NULL, 1 << 5, 0, -1},
	{"smplayer", NULL, NULL, 1 << 5, 0, -1},
	{"mpv", NULL, NULL, 1 << 5, 0, -1},
	{"yesplaymusic", NULL, NULL, 1 << 6, 0, -1},
	{"VirtualBox Manager", NULL, NULL, 1 << 7, 1, -1},
};

/* layout(s) */
static const float mfact = 0.5;		 /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;		 /* number of clients in master area */
static const int resizehints = 1;	 /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{"[T]", tile}, /* first entry is default */
	{"[F]", NULL}, /* no layout function means floating behavior */
	{"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                          \
	{MODKEY, KEY, view, {.ui = 1 << TAG}},                         \
		{MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}}, \
		{MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},          \
		{MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                           \
	{                                                        \
		.v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } \
	}

/* custom commands*/
static const char *browsercmd[] = {"google-chrome-stable", NULL};
static const char *filemanager[] = {"pcmanfm", NULL};
static const char *lockcmd[] = {"slock", NULL};
static const char *upvolcmd[] = {"/home/volta/suckless/dwm/scripts/vol-up.sh", NULL};
static const char *downvolcmd[] = {"/home/volta/suckless/dwm/scripts/vol-down.sh", NULL};
static const char *mutevolcmd[] = {"/home/volta/suckless/dwm/scripts/vol-toggle.sh", NULL};
static const char *upbacklightcmd[] = {"/home/volta/suckless/dwm/scripts/backlight-up.sh", NULL};
static const char *downbacklightcmd[] = {"/home/volta/suckless/dwm/scripts/backlight-down.sh", NULL};
static const char *screenshotcmd[] = {"/home/volta/suckless/dwm/scripts/screenshot.sh", NULL};
static const char *wpchangecmd[] = {"/home/volta/suckless/dwm/scripts/wp-change.sh", NULL};
/* commands */
static const char *dmenucmd[] = {"dmenu_run", NULL};
static const char *termcmd[] = {"st", NULL};
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = {"st", "-t", scratchpadname, "-g", "60x15", NULL};

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{MODKEY, XK_c, spawn, {.v = browsercmd}},
	{MODKEY, XK_e, spawn, {.v = filemanager}},
	{MODKEY | ShiftMask, XK_l, spawn, {.v = lockcmd}},
	{MODKEY, XK_F3, spawn, {.v = upvolcmd}},
	{MODKEY, XK_F2, spawn, {.v = downvolcmd}},
	{MODKEY, XK_F1, spawn, {.v = mutevolcmd}},
	{MODKEY, XK_F12, spawn, {.v = upbacklightcmd}},
	{MODKEY, XK_F11, spawn, {.v = downbacklightcmd}},
	{MODKEY, XK_w, spawn, {.v = wpchangecmd}},
	{NULL,XK_Print,spawn,{.v = screenshotcmd}},
	{MODKEY, XK_d, spawn, {.v = dmenucmd}},
	{MODKEY, XK_Return, spawn, {.v = termcmd}},
	{MODKEY, XK_apostrophe, togglescratch, {.v = scratchpadcmd}},
	{MODKEY, XK_b, togglebar, {0}},
	{MODKEY | ShiftMask, XK_bracketleft, rotatestack, {.i = +1}},
	{MODKEY | ShiftMask, XK_bracketright, rotatestack, {.i = -1}},
	{MODKEY, XK_j, focusstackvis, {.i = +1}},
	{MODKEY, XK_k, focusstackvis, {.i = -1}},
	{MODKEY | ShiftMask, XK_j, focusstackhid, {.i = +1}},
	{MODKEY | ShiftMask, XK_k, focusstackhid, {.i = -1}},
	{MODKEY, XK_o, incnmaster, {.i = +1}},
	{MODKEY, XK_p, incnmaster, {.i = -1}},
	{MODKEY, XK_h, setmfact, {.f = -0.05}},
	{MODKEY, XK_l, setmfact, {.f = +0.05}},
	{MODKEY, XK_Return, zoom, {0}},
	{MODKEY, XK_Tab, view, {0}},
	{MODKEY | ShiftMask, XK_q, killclient, {0}},
	{MODKEY | ShiftMask, XK_t, setlayout, {.v = &layouts[0]}},
	{MODKEY | ShiftMask, XK_f, setlayout, {.v = &layouts[1]}},
	{MODKEY | ShiftMask, XK_m, setlayout, {.v = &layouts[2]}},
	{MODKEY, XK_space, setlayout, {0}},
	{MODKEY | ShiftMask, XK_space, togglefloating, {0}},
	{MODKEY, XK_f, fullscreen, {0}},
	{MODKEY, XK_0, view, {.ui = ~0}},
	{MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
	{MODKEY, XK_comma, focusmon, {.i = -1}},
	{MODKEY, XK_period, focusmon, {.i = +1}},
	{MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
	{MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
	{MODKEY, XK_s, show, {0}},
	{MODKEY | ShiftMask, XK_s, showall, {0}},
	{MODKEY | ShiftMask, XK_h, hide, {0}},
	TAGKEYS(XK_1, 0)
		TAGKEYS(XK_2, 1)
			TAGKEYS(XK_3, 2)
				TAGKEYS(XK_4, 3)
					TAGKEYS(XK_5, 4)
						TAGKEYS(XK_6, 5)
							TAGKEYS(XK_7, 6)
								TAGKEYS(XK_8, 7)
									TAGKEYS(XK_9, 8){MODKEY | ControlMask | ShiftMask, XK_c, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ClkTagBar, MODKEY, Button1, tag, {0}},
	{ClkTagBar, MODKEY, Button3, toggletag, {0}},
	{ClkWinTitle, 0, Button1, togglewin, {0}},
	{ClkWinTitle, 0, Button2, zoom, {0}},
	{ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
	{ClkClientWin, MODKEY, Button1, movemouse, {0}},
	{ClkClientWin, MODKEY, Button2, togglefloating, {0}},
	{ClkClientWin, MODKEY, Button3, resizemouse, {0}},
	{ClkTagBar, 0, Button1, view, {0}},
	{ClkTagBar, 0, Button3, toggleview, {0}},
	{ClkTagBar, MODKEY, Button1, tag, {0}},
	{ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
