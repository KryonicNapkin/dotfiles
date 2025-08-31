/*
 * This is a configuration file for bat program to display information about laptops 
 * battery in a single line format to be used in window manager's bar as a bar script */

#ifndef BAT_CONFIG_H_
#define BAT_CONFIG_H_

/* 
 * All things in this configuration file has been sourced from the official kernel documentation:
 * https://www.kernel.org/doc/html/latest/power/power_supply_class.html and
 * https://github.com/torvalds/linux/blob/master/include/linux/power_supply.h
 */

/* Battery name as in /sys/class/power_supply directory */
#define BAT_NAME                                 "BAT0"
/* Full path to the battery */
#define BAT_PROPERTIES_FILEPATH                  "/sys/class/power_supply/" BAT_NAME "/uevent"

/* Constant names of different properties in the uevent file located in battery_path */ 
#define BAT_CAPACITY                             "POWER_SUPPLY_CAPACITY"
#define BAT_POWER_uW                             "POWER_SUPPLY_POWER_NOW"
#define BAT_STATUS_S                             "POWER_SUPPLY_STATUS"

/* Constant texts displayed at different statuses of a battery */
#define STATUS_UNKNOWN_STRING                    "Unknown"
#define STATUS_CHARGING_STRING                   "Charging"
#define STATUS_NOT_CHARGING_STRING               "Not charging"
#define STATUS_DISCHARGING_STRING                "Discharging"
#define STATUS_FULL_STRING                       "Full"

static const unsigned int minimum_cap          = 30;
static const unsigned int critical_cap         = 10;

/*---------------------------------------------------------------------------*/
/*                            NOTIFICATION TYPES                             */
/*---------------------------------------------------------------------------*/
static const char* battery_notify_name         = "Battery alerter";
static const int notification_delay_ms         = 5000;

/* 
 * LOW_CAPACITY notification is triggered when the battery's capacity is less than the
 * minimum_cap set prior 
 */
/* summary for the LOW_CAPACITY notification */
static const char* low_cap_notify_summary      = "LOW CAPACITY"; 
/* Body for the LOW_CAPACITY notification */
static const char* low_cap_notify_body         = "Please connect your laptop to power"; 

/* 
 * FULL_CAPACITY notification is triggered when the battery's capacity is 100
 */
static const char* full_cap_notify_summary     = "FULL BATTERY";
static const char* full_cap_notify_body        = "Unplug the charging cable";

/* 
 * CRITICALLY_LOW_CAPACITY notification is triggered when the battery's capacity
 * is less than critical_cap set prior
 */
static const char* critical_cap_notify_summary = "CRITICALLY LOW CAPACITY";
static const char* critical_cap_notify_body    = "Immediately connect you laptop to power";

/* 
 * UNKNOWN notification is triggered when program cannot get some battery attribute
 */
static const char* unknown_notify_summary      = "ERROR OCCURED";
static const char* unknown_notify_body         = "Something went wrong!";

#endif /* BAT_CONFIG_H_ */
