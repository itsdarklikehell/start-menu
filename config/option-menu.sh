#!/bin/bash
	choice=$(whiptail --title "Option Menu" --menu "Choose an option" 25 78 16 \
	"Update-System" "Update system." \
	"Update-start-menu" "Update startup-menu." \
	"Make-Config" "Make config files for starting/installing applications" \
	"Remove-Config" "Remove config files for starting/installing applications" \
    "Raspi-Config" "Configure raspbian." \
    "RetroPie-Setup" "Configure Retropie." \
    "Cleanup-System" "Cleanup system." 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $choice in
		Update-System)
		echo "User selected: " $choice
		sudo apt-get update && sudo apt-get upgrade
		cd $HOME/start-menu
        git pull
        echo "system update finished"
        use_whiptail="False"
        exit
		;;
		Update-start-menu)
		echo "User selected: " $choice
		cd $HOME/start-menu
        git pull
        echo "startup-menu update finished"
        use_whiptail="False"
        exit
		;;
		Make-Config)
		echo "User selected: " $choice
		bash $HOME/start-menu/config/make_config.sh
		;;
		Remove-Config)
		echo "User selected: " $choice
		bash $HOME/start-menu/config/remove_config.sh
		;;
        Raspi-Config)
		echo "User selected: " $choice
		sudo raspi-config
		;;
        RetroPie-Setup)
		echo "User selected: " $choice
        sudo $HOME/RetroPie-Setup/retropie_setup.sh
        ;;
        Cleanup-System)
		echo "User selected: " $choice
        sudo apt-get autoremove
        sudo apt-get autoclean
        ;;
        *)
		echo "You cancelled or have finished."
        ;;
	esac