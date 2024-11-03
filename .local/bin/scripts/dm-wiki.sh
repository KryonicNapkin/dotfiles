#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
wikidir="/usr/share/doc/arch-wiki/html/en/"
wikidocs="$(find ${wikidir} -iname "*.html")"

# Start of Code
main() {
    wikidocs="$(find ${wikidir}"${lang}" -iname "*.html")"
    choice=$(printf '%s\n' "${wikidocs[@]}" |
        cut -d '/' -f8- |
        sed -e 's/_/ /g' -e 's/.html//g' |
        sort |
        $dmdpy "Arch Wiki Docs:" "$@") || exit 1

    if [ "$choice" ]; then
        article=$(printf '%s\n' "${wikidir}${choice}.html" | sed 's/ /_/g')
        brave "$article"
    else
        echo "Program terminated." && exit 0
    fi
}
main

# End of Code
