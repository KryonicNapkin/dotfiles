#!/bin/sh

# Variables
remaining=$(acpi | awk '{print $5}')
state=$(acpi | awk '{print $3}' | tr -d ',')

if [ $state = "Not" ]; then
    state=$(acpi | awk '{print $4}' | tr -d ',')
    percentage=$(acpi | awk '{print $5}' | tr -d '%,')
else
    state=$(acpi | awk '{print $3}' | tr -d ',')
    percentage=$(acpi | awk '{print $4}' | tr -d '%,')
fi

if [ $state = "Discharging" ]; then
    printf "%s%s\n" "BAT " "-$percentage%"
elif [ $state = "Full" ] && [ $percentage -eq 100 ]; then
    printf "Full\n"
fi

if [ $state = "Discharging" ] && [ $percentage -le 15 ]; then
    dunstify -t 5000 -u critical "Battery is low at $percentage%, remaining $remaining" "Please plug in the charger"
elif [ $state = "Charging" ]; then
    printf "%s%s\n" "BAT " "+$percentage%"
elif [ $state = "charging" ]; then
    printf "%s%s\n" "BAT " "$percentage%"
fi
