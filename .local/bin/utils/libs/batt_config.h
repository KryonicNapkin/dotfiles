#ifndef BATT_CONFIG_H_
#define BATT_CONFIG_H_

// Default path for laptop's battery
#define BATT_DIR                       "/sys/class/power_supply/BAT0/"

/* CONSTANTS (DO NOT CHANGE!!!!) */
// Status file
static const char* batt_status_file    = BATT_DIR "status";
// Current power of the battery
static const char* batt_watt_file      = BATT_DIR "power_now";
// Current capacity of battery
static const char* batt_cap_file       = BATT_DIR "capacity";

/* Variable values that affects the program's behaviour */
// For how long the notification should be on the screen in ms
static const unsigned int notify_delay = 10000;
// Minimum capacity 
static const unsigned int low_cap      = 30; 
// 
static const unsigned int safe_cap     = 90; 
static const char* battnotif_name      = "Battery alerter";
static const char* ntfbatt_low_mesg    = "Please connect your laptop to power";
static const char* ntfbatt_full_title  = "Full battery";
static const char* ntfbatt_full_mesg   = "Unplug the charging cable";
static const char* ntfbatt_safe_title  = "You've set a safe batt notification";
static const char* ntfbatt_safe_mesg   = "For the longevity of your battery you should unplug the charging cable";
static const char* ntfbatt_error_title = "ERROR!";
static const char* ntfbatt_error_mesg  = "Something went wrong!";

#endif // BATT_CONFIG_H_ 
