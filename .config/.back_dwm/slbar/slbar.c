/* See LICENSE file for copyright and license details. */

#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <X11/Xlib.h>

#define LEN(a)    (sizeof(a) / sizeof(a)[0])
#define CMDLEN    (64)
#define BARLEN    (LEN(modules) * CMDLEN + 1)

typedef unsigned int uint;
typedef struct {
  char* cmd; /* command to be executed */
  uint  upd; /* update interval (0 means no update interval) */
  uint  sig; /* update signal (0 means no signal) */
} Module;

/* functions */
static int gcd(int a, int b);          /* greatest common divisor */
static int lcm(int a, int b);          /* least common multiple */
static void die(const char *fmt, ...); /* prints error to stderr and exits */
static void display(void);             /* displays status bar */
static void loop(void);                /* main loop of the program */
static void setup(void);               /* sets up handling signals */
static void sighandler(int sig);       /* signal handler */
static void termhandler();             /* SIGTERM handler */
static void update(uint time);         /* updates status bar */
static void updatecmd(const char *cmd, char *out); /* updates given module */

/* globals */
static Display *dpy;
static Window root;
static int screen;

#include "config.h"

static int break_loop = 0;
static uint current = 0;
static char barstr[2][BARLEN] = { 0 };
static char cmds[LEN(modules)][CMDLEN] = { 0 };

int
gcd(int a, int b)
{
  return b ? gcd(b, a % b) : a;
}

int
lcm(int a, int b)
{
  return a / gcd(a, b) * b;
}

void
die(const char *fmt, ...)
{
  va_list ap;

  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  va_end(ap);

  fputc('\n', stderr);

  exit(1);
}

void
display(void)
{
  uint old = current, new = current ^ 1;
  uint i;

  barstr[new][0] = '\0';

  for (i = 0; i < LEN(modules); i++)
    strcat(barstr[new], cmds[i]);
  barstr[new][strlen(barstr[new]) - sep_len] = '\0';

  if (!(strcmp(barstr[new], barstr[old])))
    return;

  XStoreName(dpy, root, barstr[new]);
  XFlush(dpy);
  current = new;
}

void
loop(void)
{
  uint i, upd_lcm = 1, upd_gcd = 0;

  for (i = 0; i < LEN(modules); i++) {
    upd_gcd = gcd(modules[i].upd ? modules[i].upd : upd_gcd, upd_gcd);
    upd_lcm = lcm(modules[i].upd ? modules[i].upd : 1, upd_lcm);
    updatecmd(modules[i].cmd, cmds[i]);
  }

  for (i = 0, upd_gcd = upd_gcd ? upd_gcd : 1; !break_loop; i %= upd_lcm) {
    update(i += upd_gcd);
    display();
    sleep(upd_gcd);
  }
}

void
setup(void)
{
  const Module *m;
  uint i;
  screen = DefaultScreen(dpy);
  root = RootWindow(dpy, screen);
  signal(SIGTERM, termhandler);
  signal(SIGINT,  termhandler);
  for (m = modules, i = LEN(modules); i--; m++)
    if (m->sig)
      signal(m->sig + SIGRTMIN, sighandler);
}

void
sighandler(int sig)
{
  const Module *m;
  uint i;
  for (m = modules, i = 0; i < LEN(modules); i++, m++)
    if ((int)m->sig + SIGRTMIN == sig)
      updatecmd(m->cmd, cmds[i]);
  display();
}

void
termhandler()
{
  break_loop = 1;
}

void
update(uint time)
{
  const Module *m;
  uint i;
  for (m = modules, i = 0; i < LEN(modules); i++, m++)
    if (m->upd && time % m->upd == 0)
      updatecmd(m->cmd, cmds[i]);
}

void
updatecmd(const char *cmd, char *out)
{
  FILE *fp;
  size_t len;
  *out = 0;
  if (!(fp = popen(cmd, "r")))
    return;
  fgets(out, CMDLEN - sep_len - 1, fp);
  if (!(len = strlen(out))) {
    pclose(fp);
    return;
  }
  out[len - (out[len - 1] == '\n')] = '\0';
  strcat(out, sep);
  pclose(fp);
}

int
main(int argc, char *argv[])
{
  if (argc == 2 && !strcmp("-v", argv[1]))
    die("slbar-"VERSION);
  else if (argc != 1)
    die("usage: slbar [-v]");

  if (!(dpy = XOpenDisplay(NULL)))
    die("slbar: cannot open display");

  setup();
  loop();

  XCloseDisplay(dpy);

  return EXIT_SUCCESS;
}
