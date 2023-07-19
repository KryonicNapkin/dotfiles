#!/bin/sh
cpu_temp=$(sensors | awk 'NR==3{print $4}' | tr -d '+')

printf "%s\n" "$cpu_temp"
