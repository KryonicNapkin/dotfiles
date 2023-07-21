#!/bin/bash

set -xe

# Variables
. /home/oizero/.local/share/univ/vars

cd $dwmdir && rm -f config.h && sudo make install
