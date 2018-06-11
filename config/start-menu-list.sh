#!/bin/bash
choice=$(whiptail --title "Start Tool List" --checklist \
"Select tool to start" 20 78 4 \
"Desktop" "Raspbian Pixel Desktop." ON 3>&1 1>&2 2>&3)
case $choice in
	Desktop)
	echo "User selected: " $choice
    name="Desktop"
    bash $HOME/start-menu/config/tools/$name/start.sh
    ;;
	*)
	echo "You cancelled or have finished."
	;;
esac
start_done