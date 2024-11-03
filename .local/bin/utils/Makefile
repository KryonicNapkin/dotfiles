CC		= gcc
CFLAGS 	= -std=c11 -g -Wall -Wextra -Wpedantic -Wconversion
LDFLAGS	= `pkg-config --cflags --libs libnotify`
LIBDIR 	= ./libs
SRCDIR	= ./src

all: battu dateu tempu krnlu

battu: $(SRCDIR)/battu.c
	$(CC) ${CFLAGS} ${LDFLAGS} -o $@ $<

dateu: $(SRCDIR)/dateu.c
	$(CC) ${CFLAGS} ${LDFLAGS} -o $@ $<

tempu: $(SRCDIR)/tempu.c
	$(CC) ${CFLAGS} ${LDFLAGS} -o $@ $<

krnlu: $(SRCDIR)/krnlu.c
	$(CC) ${CFLAGS} ${LDFLAGS} -o $@ $<
