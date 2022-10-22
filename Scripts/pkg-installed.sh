#!/usr/bin/env bash
set -xe

$(paru -Qe | awk '{print $1}' > pkglist.txt)
