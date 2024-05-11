#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libnotify/notify.h>
#include <libnotify/notification.h>

typedef enum BAT_STATE {
	BAT_CHARGING,
	BAT_NOT_CHARGING,
	BAT_DISCHARGING,
	BAT_FULL,
	BAT_EMPTY
} BAT_STATE;

int batt_cap(FILE *batt_cap);
BAT_STATE batt_status(FILE *batt_status);
double power_now(FILE *batt_power);

int main(void) {
    FILE *fp1, *fp2, *fp3;
    NotifyNotification *critbattacpi, *fullbattacpi, *safebattery, *errorbatt;

    char summary[20];
    char body[70];
	char *error_obtaining_capacity_summary = "ERROR";
	char *error_obtaining_capacity_body = "Could not obtain battery capacity";
    char *summary2 = "Laptop is fully charged";
    char *body2 = "Unplug the charging cable from laptop";
    char *summary3 = "Battery is at 90%";
    char *body3 = "For safety of your battery you should unplug the charging cable";
    char *appname = "Critical Battery alerter";
    char *appname2 = "Full Battery alerter";
    char *appname3 = "Safe Batter alerter";
    char *appname4 = "Error alerter";

    fp1 = fopen("/sys/class/power_supply/BAT0/capacity", "r");
    fp2 = fopen("/sys/class/power_supply/BAT0/status", "r");
    fp3 = fopen("/sys/class/power_supply/BAT0/power_now", "r");

    int cap = batt_cap(fp1);
    int status = batt_status(fp2);
	double power = power_now(fp3);

    if (cap == -1) {
    	notify_init(appname4);
    	errorbatt = notify_notification_new(error_obtaining_capacity_summary,
										   error_obtaining_capacity_body, NULL);
    	notify_notification_set_urgency(errorbatt, NOTIFY_URGENCY_CRITICAL);
    	notify_notification_set_timeout(errorbatt, 7500);
        fclose(fp1);
        fclose(fp2);
        fclose(fp3);
        exit(EXIT_FAILURE);
    } else {
        snprintf(summary, 20, "%d%% baterky!", cap);
        snprintf(body, 70, "Tvoja kapacita baterky je %d%%! Zapoj nabíjačku do počítača!", cap);
    }

    notify_init(appname);
    critbattacpi = notify_notification_new(summary, body, NULL);
    notify_notification_set_urgency(critbattacpi, NOTIFY_URGENCY_CRITICAL);
    notify_notification_set_timeout(critbattacpi, 7500);

    notify_init(appname2);
    fullbattacpi = notify_notification_new(summary2, body2, NULL);
    notify_notification_set_urgency(fullbattacpi, NOTIFY_URGENCY_NORMAL);
    notify_notification_set_timeout(fullbattacpi, 7500);

    notify_init(appname3);
    safebattery = notify_notification_new(summary3, body3, NULL);
    notify_notification_set_urgency(safebattery, NOTIFY_URGENCY_NORMAL);
    notify_notification_set_timeout(safebattery, 7500);

    switch (status) {
        case BAT_CHARGING:
            printf("BAT +%d%% %.1lfW\n", cap, power);
			if (cap >= 90) {
				notify_notification_show(safebattery, NULL);	        
				printf("BAT +%d%% %.1lfW\n", cap, power);
			}
	        break;
        case BAT_DISCHARGING:
            if (cap <= 15) {
                notify_notification_show(critbattacpi, NULL);
                printf("BAT -%d%% %.1lfW\n", cap, power);
            }
            printf("BAT -%d%% %.1lfW\n", cap, power);
        	break;
        case BAT_NOT_CHARGING:
            printf("BAT =%d%% %.1lfW\n", cap, power);
        	break;
        case BAT_FULL:
			notify_notification_show(fullbattacpi, NULL);
            printf("BAT *%d%% %.1lfW\n", cap, power);
        	break;
        case -1:
    		notify_init(appname4);
    		errorbatt = notify_notification_new(error_obtaining_capacity_summary,
										   error_obtaining_capacity_body, NULL);
    		notify_notification_set_urgency(errorbatt, NOTIFY_URGENCY_CRITICAL);
    		notify_notification_set_timeout(errorbatt, 7500);
        	break;
        default:
            fprintf(stderr, "Unknown value!\n");
        	break;
    }

    fclose(fp1);
    fclose(fp2);
    fclose(fp3);
    return EXIT_SUCCESS;
}

BAT_STATE batt_status(FILE *batt_status) {
    char str[20];

    fgets(str, 20, batt_status);
    if (!strncmp(str, "Charging\n", 20)) {
        return BAT_CHARGING;
    } else if (!strncmp(str, "Discharging\n", 20)) {
        return BAT_DISCHARGING;
    } else if (!strncmp(str, "Not charging\n", 20)) {
        return BAT_NOT_CHARGING;
    } else if (!strncmp(str, "Full\n", 20)) {
        return BAT_FULL;
    }
    return -1;
}

int batt_cap(FILE *batt_cap) {
    int cap;

    if (!fscanf(batt_cap, "%3d", &cap)) {
        return -1;
    } else {
        return cap;
    }
}

double power_now(FILE *batt_power) {
	double pwr;

	if (!fscanf(batt_power, "%lf", &pwr)) {
		return -1;
	} else {
		return pwr /= 1000000;
	}
}
