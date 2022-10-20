#!/usr/bin/env bash
set -xe

echo "$(paru -Qe | awk '{print $1}' > pkglist.txt)"
