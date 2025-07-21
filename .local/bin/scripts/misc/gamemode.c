#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEVEL   2

static const char* resolutions[] = {"2560x1600", "1920x1200", "1680x1050"};
static const int refresh_rates[] = {120, 60, 60};

int run_program(int level);

int main(int argc, char* argv[]) {
    if (argc <= 1) {
        fprintf(stderr, "Error: Not enough arguments passed!\n");
        return 1;
    }
    int level = -1;
    if (!strncmp(argv[1], "-l", 2) && strlen(argv[1]) > 2) {
        char* num = argv[1]+2;
        level = strtol(num, NULL, 10);
    }
    if (level < 0 || level > 2) {
        fprintf(stderr, "Error: Invalid level number: '%d'!\n", level);
        fprintf(stderr, "       Range 0-2\n");
        return 1;
    }
    run_program(level);
    return 0;
}

int run_program(int level) {
    char command[1024];

    sprintf(command, "xrandr --output eDP --mode %s --rate %d", resolutions[level], refresh_rates[level]);
    system(command);
    system("~/.fehbg");
    return 0;
}
