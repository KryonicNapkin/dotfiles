#!/bin/bash
#
# set -xe

word=$(:| dmenu -p "Enter english word for an example sentence:")

xdg-open "https://sentence.yourdictionary.com/$word"
