#!/bin/bash
#Startup menu for RPI made by itsdarklikehell.

config(){
	use_whiptail="True"
    WIP="WORK IN PROGRESS, NOT YET IMPLEMENTED."
}

disclaimer(){
	echo "USE THIS SCRIPT WITH CARE!"
	if (whiptail --title "Disclaimer Dialog" --yesno "Use this script with care. Continue?" 8 78) then
	main_menu
    else
    echo "User selected No, exit status was $?."
fi
}

start_done(){
	echo "Finished starting: $choice"
	whiptail --title " Finished Starting" --msgbox "Finished starting: $choice." 8 78
}

install_done(){
	echo "Finished instaling: $choice"
	whiptail --title " Finished Installing" --msgbox "Finished installing: $choice." 8 78
}

main_menu(){
	echo "main menu"
	## menu start
    while [ $use_whiptail = True ]
	do
	choice=$(whiptail --title "Main Menu" --menu "Choose an option" 25 78 16 \
	"Install" "Install tools." \
	"Start" "Start tools." \
    "Options" "Options and configuration." 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $choice in
		Install)
		echo "User selected: " $choice
		install_menu
		;;
		Start)
		echo "User selected: " $choice
		start_menu
		;;
        Options)
		echo "User selected: " $choice
		option_menu
		;;
		*)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
	esac
	done ## menu end
}

option_menu(){
bash $HOME/start-menu/config/option-menu.sh
}

install_menu(){
	echo "install menu"
	choice=$(whiptail --title "Install Menu" --menu "Choose an option" 25 78 16 \
	"List" "Install tools fom curated list." \
	"Custom" "Install custom package with apt-get." 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $choice in
		List)
		bash $HOME/start-menu/config/install-menu-list.sh
        ;;
		Custom)
		bash $HOME/start-menu/config/install-menu-custom.sh
		;;
		*)
		echo "You cancelled or have finished."
		;;
    esac
}

start_menu(){
	echo "start menu"
	choice=$(whiptail --title "Start Menu" --menu "Choose an option" 25 78 16 \
	"List" "Start tools fom curated list." \
	"Custom" "Start custom command if present." 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $choice in
		List)
        bash $HOME/start-menu/config/start-menu-list.sh
        ;;
		Custom)
		bash $HOME/start-menu/config/start-menu-custom.sh
		;;
		*)
		echo "You cancelled or have finished."
		;;
	esac
}

config
disclaimer