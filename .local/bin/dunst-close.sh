#!/bin/sh

wid=$(xdotool search --class wired | tail -1)
xdotool mousemove --window $wid 1 1 click 1
