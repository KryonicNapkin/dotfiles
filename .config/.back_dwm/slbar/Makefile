# slbar - simple (suckless) bar for dwm
# See LICENSE file for copyright and license details.

.POSIX:

VERSION  = 1.1
PREFIX   = /usr/local
CPPFLAGS = -DVERSION=\"$(VERSION)\"
CFLAGS   = -pedantic -Wall -Wextra -Wno-deprecated-declarations -Wno-implicit-fallthrough -Os $(CPPFLAGS)
LDFLAGS  = -lX11
CC       = cc

all: options slbar

options:
	@echo slbar build options:
	@echo "CFLAGS  = $(CFLAGS)"
	@echo "LDFLAGS = $(LDFLAGS)"
	@echo "CC      = $(CC)"

slbar: slbar.c config.h
	$(CC) -o slbar slbar.c $(CFLAGS) $(LDFLAGS)

clean:
	rm -f slbar slbar.o

install: slbar
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f slbar $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/slbar

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/slbar

.PHONY: all options clean install uninstall
