#!/bin/bash

state=$(acpi | awk '{print $3}' | tr -d ',')

if [[ $state == "Not" ]]; then
    state=$(acpi | awk '{print $4}' | tr -d ',')
    percentage=$(acpi | awk '{print $5}' | tr -d '%,')
else
    state=$(acpi | awk '{print $3}' | tr -d ',')
    percentage=$(acpi | awk '{print $4}' | tr -d '%,')
fi

if [ $state == "Discharging" ]; then
    printf "%s%s" "BAT " "-$percentage%"
elif [ $state == "Full" ] && [ $percentage -eq 100 ]; then
    printf "Full"
fi

if [ $state == "Discharging" ] && [ $percentage -le 10 ]; then
    notify-send "Battery is too low" "Please plug the power"
elif [ $state == "Charging" ]; then
    printf "%s%s" "BAT " "+$percentage%"
elif [ $state == "charging" ]; then
    printf "%s%s" "BAT " "$percentage%"
fi
