#!/bin/bash
choice=$(whiptail --title "Start Tool List" --radiolist \
"Select tool to start" 20 78 4 \
'Default' 'Default' ON \
'Exit' 'Exit to CLI.' ON 3>&1 1>&2 2>&3)
case $choice in
	Default)
	echo "User selected: " $choice
    name=Default
    bash $HOME/start-menu/config/tools/$name/start.sh
    ;;
	*)
	echo "You cancelled or have finished."
	;;
	Exit)
	echo "You cancelled or have finished."
	;;
esac