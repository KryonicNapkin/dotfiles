CC		= gcc
CFLAGS 	= -Wall -g `pkg-config --cflags --libs libnotify`

default: all

objects = dwm-bat dwm-date dwm-temp dwm-krnl
all: $(objects)

$(objects): %: src/%.c
		$(CC) $(CFLAGS) $< -o $@
