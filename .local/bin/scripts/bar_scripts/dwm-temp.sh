#!/bin/bash

set -xe
cpu_temp=$(sensors | awk 'NR==13{print $3}' | tr -d '+')

printf "TMP %s\n" "$cpu_temp"
