/*
 * This program is for my personal use only. Use at will!!!
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/stat.h>
#include <libnotify/notify.h>
#include <libnotify/notification.h>
#include <unistd.h>
#include <errno.h>

/* config for this program */
#include "../bat_config.h"

typedef enum {
    STATUS_UNKNOWN = 0,
	STATUS_CHARGING,
	STATUS_DISCHARGING,
	STATUS_NOT_CHARGING,
	STATUS_FULL, 
} Battery_status_t;

typedef struct {
    const char* name;
    char* status_string;
    Battery_status_t status;
    float power_w;
    unsigned int cap;
} Battery_t;

typedef enum {
    LOW_CAPACITY = 0,
    CRITICALLY_LOW_CAPACITY,
    FULL_CAPACITY,
    ERROR,
} Notification_type_t;

Battery_t get_battery_properties(void);
float get_battery_power(void);
unsigned int get_battery_capacity(void);
Battery_status_t get_battery_status(char** status_string);

int should_trigger_notification(unsigned int cap, Battery_status_t status, Notification_type_t* type);
int trigger_notification(Notification_type_t type);

/* prop_name as in /sys/class/power_supply/ BAT_NAME /uevent written in CAPITAL LETTERS */
char* get_battery_prop(const char* prop_name);
char* sdup(const char* str);

void usage(Battery_t battery);

static const char status_chars[5] = {'E', '+', '-', 'N', '='};

int main(int argc, char* argv[]) {
    struct stat st = {0};
    if (stat(BAT_PROPERTIES_FILEPATH, &st) == -1) {
        fprintf(stderr, "Error: Could not open '%s': %s\n", BAT_PROPERTIES_FILEPATH, strerror(errno));
        return 1;
    }

    Battery_t battery = get_battery_properties();

    int nflag = 0;
    int len = 0;

    char* output = malloc(256);
    if (argc == 1 || (argc == 2 && !strcmp(argv[1], "-n"))) snprintf(output, 256, "%c%d%% %.2fW", status_chars[battery.status], battery.cap, battery.power_w);
    
    for (int i = 1; i < argc; ++i) {
        if (!strncmp(argv[i], "-w", 2) || !strncmp(argv[i], "--watts", 7)) {
            len += sprintf(output+len, " %.2fW", battery.power_w);
        } else if (!strncmp(argv[i], "-S", 5) || !strncmp(argv[i], "--status-string", 15)) {
            len += sprintf(output+len, " %s", battery.status_string);
        } else if (!strncmp(argv[i], "-s", 2) || !strncmp(argv[i], "--status", 8)) {
            len += sprintf(output+len, "%c", status_chars[battery.status]);
        } else if (!strncmp(argv[i], "-c", 2) || !strncmp(argv[i], "--capacity", 10)) {
            len += sprintf(output+len, " %d%%", battery.cap);
        } else if (!strncmp(argv[i], "-n", 2) || !strncmp(argv[i], "--notify", 8)) ++nflag;
        else if (!strncmp(argv[i], "-h", 2) || !strncmp(argv[i], "--help", 6)) {
            usage(battery);
            goto exit;
        }
    }

    /* Special format for battery.statu char; removes space after it */
    if (isspace(*output)) memmove(output, output+1, strlen(output));
    else if (*output == status_chars[battery.status] && isspace(output[1])) memmove(output+1, output+2, strlen(output));

    printf("%s\n", output);

    if (nflag) {
        Notification_type_t type;
        if (should_trigger_notification(battery.cap, battery.status, &type)) trigger_notification(type);
    }

    exit:
        free(battery.status_string);
        free(output);
        return 0;
}

Battery_t get_battery_properties(void) {
    char* status_str = malloc(32);
    
    Battery_status_t status = get_battery_status(&status_str); 
    Battery_t battery = {
        .status = status,
        .status_string = sdup(status_str),
        .cap = get_battery_capacity(),
        .name = BAT_NAME,
        .power_w = get_battery_power(),
    };

    free(status_str);
    return battery;
}

float get_battery_power(void) {
    char* power_uW_str = get_battery_prop(BAT_POWER_uW);
    float power = strtof(power_uW_str, NULL);

    free(power_uW_str);

    /* micro watts to watts */
    return power / 1000000.0f;
}

unsigned int get_battery_capacity(void) {
    char* capacity_str = get_battery_prop(BAT_CAPACITY);
    unsigned int capacity = (unsigned int)strtoul(capacity_str, NULL, 10);

    free(capacity_str);

    return capacity;
}

Battery_status_t get_battery_status(char** status_string) {
    char* status_str = get_battery_prop(BAT_STATUS_S);
    if (status_string != NULL) memcpy(*status_string, status_str, strlen(status_str) + 1);

    Battery_status_t battery_status = 0;
    if (!strncmp(status_str, STATUS_CHARGING_STRING, strlen(STATUS_CHARGING_STRING))) {
        battery_status = STATUS_CHARGING;
    } else if (!strncmp(status_str, STATUS_DISCHARGING_STRING, strlen(STATUS_DISCHARGING_STRING))) {
        battery_status = STATUS_DISCHARGING;
    } else if (!strncmp(status_str, STATUS_NOT_CHARGING_STRING, strlen(STATUS_NOT_CHARGING_STRING))) {
        battery_status = STATUS_NOT_CHARGING;
    } else if (!strncmp(status_str, STATUS_FULL_STRING, strlen(STATUS_FULL_STRING))) {
        battery_status = STATUS_FULL;
    }

    free(status_str);
    return battery_status;
}

int should_trigger_notification(unsigned int cap, Battery_status_t status, Notification_type_t* type) {
    if (cap < minimum_cap && cap > critical_cap && status != STATUS_CHARGING) *type = LOW_CAPACITY;
    else if (cap < critical_cap && status != STATUS_CHARGING) *type = CRITICALLY_LOW_CAPACITY;
    else if (cap == 100) *type = FULL_CAPACITY; 
    else {
        *type = ERROR;
        return 0;
    };
    return 1;
}

int trigger_notification(Notification_type_t type) {
    NotifyNotification* bat_notify;

    const char* summaries[4]    = {low_cap_notify_summary, critical_cap_notify_summary, full_cap_notify_summary, unknown_notify_summary};
    const char* bodies[4]       = {low_cap_notify_body,    critical_cap_notify_body,    full_cap_notify_body,    unknown_notify_body};
    const NotifyUrgency urgs[4] = {NOTIFY_URGENCY_NORMAL,  NOTIFY_URGENCY_CRITICAL,     NOTIFY_URGENCY_NORMAL,   NOTIFY_URGENCY_CRITICAL};

    notify_init(battery_notify_name);

    bat_notify = notify_notification_new(summaries[type], bodies[type], NULL);
    notify_notification_set_urgency(bat_notify, urgs[type]);
    notify_notification_set_timeout(bat_notify, notification_delay_ms);
    notify_notification_show(bat_notify, NULL);

    return 0;
}

void usage(Battery_t battery) {
	fprintf(stdout, "usage: bat OPTIONS\n");
	fprintf(stdout, "Get info about your battery and notify about it\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "With no options, it prints '%c%d%% %.2fW' \n", status_chars[battery.status], battery.cap, battery.power_w);
	fprintf(stdout, "\n");
	fprintf(stdout, "OPTIONS:\n");
	fprintf(stdout, "    -n, --notify        turn on notifications\n");
	fprintf(stdout, "    -s, --status        prints battery's STATUS as a character\n");
	fprintf(stdout, "    -S, --status-str    prints battery's STATUS as a character\n");
	fprintf(stdout, "    -w, --watts         prints current wattage of battery\n");
	fprintf(stdout, "    -c, --capacity      prints current battery capacity (in %%)\n");
	fprintf(stdout, "    -h, --help          displays this help message\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "NOTE: \n");
	fprintf(stdout, "Option -n will notify you when battery's capacity dips below specified value in config.h, only when it changes capacity\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "STATUS:\n");
	fprintf(stdout, "    '+' Charging\n");
	fprintf(stdout, "    '-' Discharging\n");
	fprintf(stdout, "    'N' Not charging\n");
	fprintf(stdout, "    '=' Full\n");
	fprintf(stdout, "    'E' Error\n");
	fprintf(stdout, "\n");
	fprintf(stdout, "Examples:\n");
	fprintf(stdout, "    bat -s -w -c        prints: %c%.2fW %d%%\n", status_chars[battery.status], battery.power_w, battery.cap);
	fprintf(stdout, "    bat -c              prints: %d%%\n", battery.cap);
	fprintf(stdout, "    bat -s              prints: %c\n", status_chars[battery.status]);
	fprintf(stdout, "    bat -S              prints: %s\n", battery.status_string);
	fprintf(stdout, "    bat -w              prints: %.2fW\n", battery.power_w);
	fprintf(stdout, "    bat -s -c -w -n     prints: %c%d%% %.2fW and on notifications\n", status_chars[battery.status], battery.cap, battery.power_w);
}

char* get_battery_prop(const char* prop_name) {
    FILE* fp = fopen(BAT_PROPERTIES_FILEPATH, "r");
    if (fp == NULL) {
        perror("Error: Could not open uevent file: ");
        exit(EXIT_FAILURE);
    }

    char buff[1024];
    char* value = malloc(32);

    while (fgets(buff, sizeof(buff), fp) != NULL) {
        if (strstr(buff, prop_name)) {
            char* prop = strchr(buff, '=');
            if (prop == NULL) {
                fprintf(stderr, "Could not get the power of your battery!\n");
                free(value);
                fclose(fp);
                return NULL;
            }
            prop[strcspn(prop, "\n")] = '\0';
            memcpy(value, prop+1, strlen(prop+1) + 1);
            break;
        }
    }
    
    fclose(fp);
    return value;
}

char* sdup(const char* str) {
    size_t len = strlen(str) + 1;
    char* nstr = malloc(len);
    memcpy(nstr, str, len);
    return nstr;
}
