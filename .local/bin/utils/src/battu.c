#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libnotify/notification.h>
#include <libnotify/notify.h>
#include <getopt.h>
#include <stdbool.h>

#include "../libs/batt_config.h"

typedef const char* path;
typedef char state;

void usage(void);
double get_watt(path watt_file);
int get_cap(path cap_file);
void notify_batts(int cap, state c);
state batt_status(path stat_file);

int
main(int argc, char *argv[]) {
    state batt_st;
	double watts;
    int capacity;
    int index_state_str;

    bool wflag = false;
    bool cflag = false;
    bool sflag = false;

	char* pwhole_str = calloc(32, sizeof(char));
    char temp_str[8];
    char ch;

    if (argc > 1) {
        for (int i = 1; i < argc; ++i) {
            if (!strncmp(argv[i], "-w", 2)) {
				watts = get_watt(batt_watt_file);
				snprintf(temp_str, 8, " %.1lfW", watts / 1000000);
                strcat(pwhole_str, temp_str);
                wflag = true;
            } else if (!strncmp(argv[i], "-c", 2)) {
				capacity = get_cap(batt_cap_file);
				snprintf(temp_str, 8, " %d%%", capacity);
                strcat(pwhole_str, temp_str);
                cflag = true;
            } else if (!strncmp(argv[i], "-s", 2)) {
				batt_st = batt_status(batt_status_file);
				snprintf(temp_str, 4, " %c", batt_st);
                strcat(pwhole_str, temp_str);
                sflag = true;
            } else if (!strncmp(argv[i], "-n", 2)) {
				capacity = get_cap(batt_cap_file);
                ch = batt_status(batt_status_file);
                notify_batts(capacity, ch);
            } else if (!strncmp(argv[i], "-h", 2)) {
				usage();
                exit(EXIT_SUCCESS);
            } else {
                fprintf(stderr, "Unknow option '%s'\n", argv[i]);
                free(pwhole_str);
                exit(EXIT_FAILURE);
            }
        }
    } else {
        usage();
        free(pwhole_str);
        return EXIT_SUCCESS;
    }

    memmove(pwhole_str, pwhole_str+1, strlen(pwhole_str));
    index_state_str = strcspn(pwhole_str, &batt_st);
    if ((sflag && (cflag || wflag)) || index_state_str > 0) {
        strcpy(&pwhole_str[index_state_str+1], &pwhole_str[index_state_str+2]);
    }
    strcat(pwhole_str, "\n");
    fputs(pwhole_str, stdout);
    fflush(stdout);
    free(pwhole_str);
	return EXIT_SUCCESS;
}

void
usage(void) {
	fprintf(stdout, "usage: battu OPTIONS\n");
	fprintf(stdout, "Get info about your battery and notify about it\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "With no options, it prints new line character '\\n'\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "OPTIONS:\n");
	fprintf(stdout, "    -n    turn on notifications\n");
	fprintf(stdout, "    -s    prints battery's STATUS as a character\n");
	fprintf(stdout, "    -w    prints current wattage of battery\n");
	fprintf(stdout, "    -c    prints current battery capacity (%%)\n");
	fprintf(stdout, "    -h    displays this help message\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "Option -n will notify you when battery's capacity dips below specified value in config.h\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "STATUS:\n");
	fprintf(stdout, "    '+' Charging\n");
	fprintf(stdout, "    '-' Discharging\n");
	fprintf(stdout, "    'N' Not charging\n");
	fprintf(stdout, "    '=' Full\n");
	fprintf(stdout, "    'E' Error\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "Examples:\n");
	fprintf(stdout, "    battu -swc    prints: -y.zW x%%\n");
	fprintf(stdout, "    battu -c      prints: x%%\n");
	fprintf(stdout, "    battu -s      prints: -\n");
	fprintf(stdout, "    battu -w      prints: y.zW\n");
	fprintf(stdout, "    battu -scw -n prints: -x%% y.zW AND turns on notifications\n");
}

int
get_cap(path cap_file) {
    int cap;
    FILE *fp;

    if ((fp = fopen(cap_file, "r")) == NULL) {
        perror("Error: ");
        return -1;
    }

    if (!fscanf(fp, "%3d", &cap)) {
        fprintf(stderr, "Could not read the file '%s'!\n", cap_file);
        return -1;
    } 
    fclose(fp);
    return cap;
}

double
get_watt(path watt_file) {
    double watt;
    FILE *fp;

    if ((fp = fopen(watt_file, "r")) == NULL) {
        perror("Error: ");
        return -1;
    }

    if (fscanf(fp, "%lf", &watt) == -1) {
        fprintf(stderr, "Could not read the file '%s'!\n", watt_file);
    }
    fclose(fp);
    return watt;
}

state
batt_status(path stat_file) {
    FILE *fp;

    if ((fp = fopen(stat_file, "r")) == NULL) {
        perror("Error: ");
        return -1;
    }

    char status[32];
    if ((fgets(status, sizeof(status), fp)) == NULL) {
        fprintf(stderr, "Error: Could not read the file '%s'", stat_file);
        return -1;
    }
    status[strcspn(status, "\n")] = '\0';
    if (strncmp("Discharging", status, 11) == 0) {
        return '-';
    } else if (strncmp("Charging", status, 8) == 0) {
        return '+';
    } else if (strncmp("Not charging", status, 12) == 0) {
        return 'N';
    } else if (strncmp("Full", status, 4) == 0) {
        return '=';
    } else {
        return 'E';
    }
    fclose(fp);
}

void
notify_batts(int cap, state s) {
    NotifyNotification *ntf_low, *ntf_full, *ntf_error, *ntf_safe;

    char low_cap_title[32];
    snprintf(low_cap_title, sizeof(low_cap_title), "%d%% Low battery", cap);

    if (cap <= low_cap && cap > 0 && s != '+') {
        notify_init(battnotif_name);
        ntf_low = notify_notification_new(low_cap_title, ntfbatt_low_mesg, NULL);
        notify_notification_set_urgency(ntf_low, NOTIFY_URGENCY_CRITICAL);
        notify_notification_set_timeout(ntf_low, notify_delay);
        notify_notification_show(ntf_low, NULL);
    } else if ((cap >= safe_cap && cap != 100 && s != '-') && safe_cap > 0) {
        notify_init(battnotif_name);
        ntf_safe = notify_notification_new(ntfbatt_safe_title, ntfbatt_safe_mesg, NULL);
        notify_notification_set_urgency(ntf_safe, NOTIFY_URGENCY_NORMAL);
        notify_notification_set_timeout(ntf_safe, notify_delay);
        notify_notification_show(ntf_safe, NULL);
    } else if (cap == 100 && s != '-') {
        notify_init(battnotif_name);
        ntf_full = notify_notification_new(ntfbatt_full_title, ntfbatt_full_mesg, NULL);
        notify_notification_set_urgency(ntf_full, NOTIFY_URGENCY_NORMAL);
        notify_notification_set_timeout(ntf_full, notify_delay);
        notify_notification_show(ntf_full, NULL);
    } else if (cap < 0) {
        notify_init(battnotif_name);
        ntf_error = notify_notification_new(ntfbatt_error_title, ntfbatt_error_mesg, NULL);
        notify_notification_set_urgency(ntf_error, NOTIFY_URGENCY_NORMAL);
        notify_notification_set_timeout(ntf_error, notify_delay);
        notify_notification_show(ntf_error, NULL);
    }
}
