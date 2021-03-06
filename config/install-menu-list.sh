#!/bin/bash
install_done(){
	echo "Finished instaling: $choice"
	whiptail --title " Finished Installing" --msgbox "Finished installing: $choice." 8 78
}

choice=$(whiptail --title "Install Tool List" --checklist \
"Select tool to install" 20 78 4 \
"Desktop" "Raspbian Pixel Desktop." ON 3>&1 1>&2 2>&3)
case $choice in
	Desktop)
	echo "User selected: " $choice
    name="Desktop"
    bash $HOME/start-menu/config/tools/$name/install.sh
    ;;
	*)
	echo "You cancelled or have finished."
	;;
esac
install_done