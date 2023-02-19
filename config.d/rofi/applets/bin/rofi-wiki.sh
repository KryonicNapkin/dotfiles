#!/bin/bash


wikidir="/usr/share/doc/arch-wiki/html/en/"
wikidocs="$(find ${wikidir} -iname "*.html")"


main() {
    wikidocs="$(find ${wikidir}"${lang}" -iname "*.html")"
    choice=$(printf '%s\n' "${wikidocs[@]}" | \
           cut -d '/' -f8- | \
           sed -e 's/_/ /g' -e 's/.html//g' | \
           sort | \
           rofi -dmenu -p "Arch Wiki Docs:" -theme ~/.config/rofi/launchers/type-4/style-1_wiki.rasi "$@") || exit 1

    if [ "$choice" ]; then
        article=$(printf '%s\n' "${wikidir}${choice}.html" | sed 's/ /_/g')
        brave "$article"
    else
        echo "Program terminated." && exit 0
    fi
}

main
