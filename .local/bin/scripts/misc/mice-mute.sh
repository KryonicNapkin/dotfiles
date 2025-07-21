#!/bin/bash

amixer -D pulse sset Capture toggle && amixer get Capture | grep '\[off\]' && notify-send "MIC switched OFF" || notify-send "MIC switched ON"
