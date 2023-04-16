#!/bin/bash

xkb_layout=$(xkblayout-state print %s)

printf "%s" "$xkb_layout"
