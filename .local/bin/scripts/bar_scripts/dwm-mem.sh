#!/bin/bash

mem="$(free -m | awk 'NR==2{printf $3"MB"}')"
printf "%s%s\n" "RAM " "$mem"
