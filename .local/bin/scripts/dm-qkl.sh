#!/bin/bash

# Debuggins
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables

# Start of Code
case "$(printf "Terraria Wiki\\nSmartbooks\\nKataster\\nMHD\\nC Exercises\\n3Dviewer\\nProtonDB\\nSuckless\\nScpwiki\\nSOŠEdupage\\nZSEdupage\\nBezkriedy\\nAur\\nHeureka\\nAlza\\nAndreaShop\\nTinkercad\\nArchlinux\\nYoutube\\nCommons Wikipedia\\nReddit\\nGmail\\nItsfoss\\nTheverge\\nGithub\\nWikipedia\\nNationstates issues\\nNationstates\\nArchWiki\\nVox\\nOurWorldinData\\nMatPriklady\\nCalamity Mod Wiki\\n" | sort | $dmdpy "Open in "${BROWSER}":")" in
"Calamity Mod Wiki")
    $BROWSER https://calamitymod.wiki.gg/
    ;;
"MatPriklady")
    $BROWSER https://www.priklady.com/sk/ 
    ;;
"Smartbooks")
    $BROWSER https://smartbooks.sk/
    ;;
"Terraria Wiki")
	$BROWSER https://terraria.wiki.gg/ 
	;;
"Suckless")
    $BROWSER https://suckless.org/
    ;;
"Nationstates issues")
    $BROWSER https://www.mwq.dds.nl/ns/results/
    ;;
"ProtonDB")
    $BROWSER https://protondb.com/
    ;;
"Scpwiki")
    $BROWSER https://scp-wiki.wikidot.com/
    ;;
"3Dviewer")
    $BROWSER https://3dviewer.net/
    ;;
"SOŠEdupage")
    $BROWSER https://spojenaskolanivysala.edupage.org/
    ;;
"ZSEdupage")
    $BROWSER https://zsmurgasa.edupage.org/
    ;;
"Bezkriedy")
    $BROWSER https://bezkriedy.sk/
    ;;
"Archlinux")
    $BROWSER https://archlinux.org/
    ;;
"AndreaShop")
    $BROWSER https://andreashop.sk/
    ;;
"Alza")
    $BROWSER https://alza.sk/
    ;;
"Aur")
    $BROWSER https://aur.archlinux.org/
    ;;
"Heureka")
    $BROWSER https://heureka.sk/
    ;;
"Tinkercad")
    $BROWSER https://tinkercad.com/
    ;;
"Youtube")
    $BROWSER https://youtube.com/
    ;;
"Commons Wikipedia")
    $BROWSER https://commons.wikipedia.org/
    ;;
"Reddit")
    $BROWSER https://reddit.com/
    ;;
"Gmail")
    $BROWSER https://gmail.com/
    ;;
"Itsfoss")
    $BROWSER https://itsfoss.com/
    ;;
"Theverge")
    $BROWSER https://theverge.com/
    ;;
"Github")
    $BROWSER https://github.com/
    ;;
"Wikipedia")
    $BROWSER https://wikipedia.org/
    ;;
"Nationstates")
    $BROWSER https://nationstates.net/
    ;;
"ArchWiki")
    $BROWSER https://wiki.archlinux.org/
    ;;
"C Exercises")
    $BROWSER https://cscx.org/
    ;;
"Vox")
    $BROWSER https://vox.com/
    ;;
"MHD")
    $BROWSER https://gileri.github.io/OSMTransportViewer/
   ;;
"Kataster")
    $BROWSER https://zbgis.skgeodesy.sk/mkzbgis/sk/kataster
    ;;
"OurWorldinData")
    $BROWSER https://ourworldindata.com/
    ;;
*)
    echo default
    ;;
esac

# End of Code
