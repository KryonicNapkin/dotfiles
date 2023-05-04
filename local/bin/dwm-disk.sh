#!/bin/sh

disk=$(df -h | awk 'NR==4{print $3, $5}')
printf "%s\n" "$disk"
