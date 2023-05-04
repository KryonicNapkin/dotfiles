#!/bin/sh
cpu_temp=$(sensors | awk 'NR==13{print $2}' | tr -d '+')

printf "%s\n" "$cpu_temp"
