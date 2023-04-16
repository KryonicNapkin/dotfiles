#!/bin/bash

backlight=$(blight get)
percentage=$(echo "scale=2; $backlight / 255 * 100" | bc | tr -d '.00')

if [ $percentage -ne 1 ]; then
    printf "%s" "$percentage%"
else 
    printf "%s" "100%"
fi
