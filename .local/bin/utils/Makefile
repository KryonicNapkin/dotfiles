CC		= gcc
CFLAGS 	= -std=c11 -g -Wall -Wextra -Wpedantic -Wconversion
LDFLAGS	= -lm `pkg-config --cflags --libs libnotify`
PROGRAMS = krnlu tempu dateu bat

all: $(PROGRAMS)

$(PROGRAMS): %: src/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
