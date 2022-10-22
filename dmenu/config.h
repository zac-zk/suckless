/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"JetBrains Mono:size=15"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static char termcol0[] = "#3b4252"; /* black   */
static char termcol1[] = "#bf616a"; /* red     */
static char termcol2[] = "#a3be8c"; /* green   */
static char termcol3[] = "#ebcb8b"; /* yellow  */
static char termcol4[] = "#81a1c1"; /* blue    */
static char termcol5[] = "#b48ead"; /* magenta */
static char termcol6[] = "#88c0d0"; /* cyan    */
static char termcol7[] = "#e5e9f0"; /* white   */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { termcol7, termcol0 },
	[SchemeSel] = { termcol7, termcol1 },
	[SchemeSelHighlight] = { termcol3, termcol1 },
	[SchemeNormHighlight] = { termcol3, termcol0 },
	[SchemeOut] = { "#000000", "#00ffff" },
	[SchemeOutHighlight] = { termcol1, "#00ffff" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
