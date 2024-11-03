#!/bin/bash

netcheck=$(ping -w 1 8.8.8.8 | awk 'NR==2{printf $1}')
printf "%s\n" "$netcheck"
