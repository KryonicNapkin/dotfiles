/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
static int incremental = 0; /* -r  option; if 1, outputs text each time a key is pressed */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const int user_bh = 6; /* add an defined amount of pixels to the bar height */
static const char *fonts[] = {"JetBrainsMonoNL:size=8"};
static const char *prompt = NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = {"#abb2bf", "#282c34"},
    [SchemeNormHighlight] = {"#ffffff", "#282c34"},
    [SchemeSelHighlight] = {"#ffffff", "#61afef"},
    [SchemeSel] = {"#000000", "#61afef"},
    [SchemeOut] = {"#000000", "#00ffff"},
    [SchemeOutHighlight] = {"#e5c07b", "#00ffff"},
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;
/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
