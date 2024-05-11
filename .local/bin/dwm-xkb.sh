#!/bin/sh

xkb_layout=$(xkblayout-state print %s)
printf "XKB %s\n" "$xkb_layout"
