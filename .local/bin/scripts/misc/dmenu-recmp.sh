#!/bin/bash

set -xe

# Variables
. /home/oizero/.local/share/univ/vars

cd $dmdir && rm -f config.h && sudo make install
