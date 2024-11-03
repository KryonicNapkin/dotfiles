#!/bin/bash

disk=$(df -h | awk 'NR==5{print $4, $5}')
printf "SSD %s\n" "$disk"
