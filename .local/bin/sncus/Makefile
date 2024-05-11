CC		= gcc
CFLAGS 	= -Wall -g `pkg-config --cflags --libs libnotify`

default: all

objects = battu dateu tempu krnlu
all: $(objects)

$(objects): %: src/%.c
		$(CC) $(CFLAGS) $< -o $@
