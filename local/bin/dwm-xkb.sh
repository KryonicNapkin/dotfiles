#!/bin/sh

xkb_layout=$(xkblayout-state print %s)
printf "%s\n" "$xkb_layout"
