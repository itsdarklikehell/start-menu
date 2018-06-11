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
bash config/option-menu.sh
}

install_menu(){
	echo "install menu"
	choice=$(whiptail --title "Install Menu" --menu "Choose an option" 25 78 16 \
	"List" "Install tools fom curated list." \
	"Custom" "Install custom package with apt-get." 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $choice in
		List)
		echo "User selected: " $choice
		install_list_menu
        ;;
		Custom)
		echo "User selected: " $choice
        choice=$(whiptail --inputbox "Please specify the package to install:" 8 78 synaptic --title "Custom install Dialog" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
    		echo "Ok, instaling:" $choice
    		sudo apt-get install $choice
            install_done
		else
    		echo "User selected Cancel."
		fi
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
		echo "User selected: " $choice
		start_list_menu
        ;;
		Custom)
		echo "User selected: " $choice
        choice=$(whiptail --inputbox "Please specify the command to run:" 8 78 synaptic --title "Custom comand Dialog" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
    		echo "Ok, stating:" $choice
    		bash $choice
            start_done
		else
    		echo "User selected Cancel."
		fi
		;;
		*)
		echo "You cancelled or have finished."
		;;
	esac
}

start_list_menu(){
bash $HOME/start-menu/config/start-menu-list.sh
}

install_list_menu(){
bash $HOME/start-menu/config/install-menu-list.sh
}

config
disclaimer