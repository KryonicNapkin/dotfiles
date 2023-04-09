#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Quick Links

# Import Current Theme
theme="$HOME/.config/rofi/configs/applets_style-1.rasi"

# Theme Elements
prompt='Quick Links'
mesg="Using Brave as web browser"

if [[ ( "$theme" == *'applets_style-1'* ) ]]; then
	list_col='1'
	list_row='6'
fi

if [[ ( "$theme" == *'applets_style-1'* ) ]]; then
	efonts="JetBrains Mono Nerd Font 10"
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Google"
	option_2=" Gmail"
	option_3=" Youtube"
	option_4=" Github"
	option_5=" Reddit"
	option_6=" ItsFoss"
	option_7=" Bezkriedy"
	option_8=" Edupage"
	option_9=" Logos Ideas"
  option_10=" Arch Wiki"
  option_11=" OurWorldInData"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
	option_6=""
	option_7=""
	option_8=""
	option_9=""
	option_10=""
  option_11=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7\n$option_8\n$option_9\n$option_10\n$option_11" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		xdg-open 'https://www.google.com/'
	elif [[ "$1" == '--opt2' ]]; then
		xdg-open 'https://mail.google.com/'
	elif [[ "$1" == '--opt3' ]]; then
		xdg-open 'https://www.youtube.com/'
	elif [[ "$1" == '--opt4' ]]; then
		xdg-open 'https://www.github.com/'
	elif [[ "$1" == '--opt5' ]]; then
		xdg-open 'https://www.reddit.com/'
	elif [[ "$1" == '--opt6' ]]; then
		xdg-open 'https://www.itsfoss.com/'
	elif [[ "$1" == '--opt7' ]]; then
		xdg-open 'https://bezkriedy.sk/'
	elif [[ "$1" == '--opt8' ]]; then
		xdg-open 'https://zsmurgasa.edupage.org/'
	elif [[ "$1" == '--opt9' ]]; then
		xdg-open 'https://commons.wikimedia.org/wiki/Category:SVG_by_country'
	elif [[ "$1" == '--opt10' ]]; then
		brave 'https://wiki.archlinux.org/'
	elif [[ "$1" == '--opt11' ]]; then
		brave 'https://ourworldindata.org/'
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
    $option_7)
    run_cmd --opt7
    		;;
    $option_8)
    run_cmd --opt8
    		;;
		$option_9)
    run_cmd --opt9
    		;;
		$option_10)
    run_cmd --opt10
    		;;
		$option_11)
    run_cmd --opt11
    		;;
esac
