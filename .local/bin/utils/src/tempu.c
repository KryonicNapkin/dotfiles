#include <stdio.h>
#include <stdlib.h>

#define BUFFER 10 // lenght of unix temp file string (num)

int main(int argc, char **argv) {
    char temp_s[BUFFER];
    FILE *fp = fopen("/sys/class/thermal/thermal_zone0/temp", "r");

    if (fp == NULL) {
        fprintf(stderr, "Cannot open file!\n");
        exit(EXIT_FAILURE);
    }

    fgets(temp_s, BUFFER, fp);
    double temp = atof(temp_s);
    temp /= 1000;

    fprintf(stdout, "TMP %g°C\n", temp);

    fclose(fp);
    return EXIT_SUCCESS;
}
