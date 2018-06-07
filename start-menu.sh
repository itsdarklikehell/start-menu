#!/bin/bash
#Startup menu for RPI made by itsdarklikehell.

config(){
	use_whiptail="True"
    WIP=echo "WORK IN PROGRESS, NOT YET IMPLEMENTED."
}

disclaimer(){
	echo "USE THIS SCRIPT WITH CARE!"
	if (whiptail --title "Disclaimer Dialog" --yesno "Use this script with care. Continue?" 8 78) then
	main_menu
    else
    echo "User selected No, exit status was $?."
fi
}

main_menu(){
	echo "main menu"
	## menu start
    while [ $use_whiptail = True ]
	do
	choice=$(whiptail --title "Main Menu" --menu "Choose an option" 25 78 16 \
	"Install" "Install tools." \
	"Start" "Start tools." \
    "Options" "Options and configuration." \
    "Exit" "Exit back to CLI" 3>&1 1>&2 2>&3)
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
		Exit)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
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
echo "options menu"
	## menu start
    while [ $use_whiptail = True ]
	do
	choice=$(whiptail --title "Option Menu" --menu "Choose an option" 25 78 16 \
	"Update-System" "Update system." \
	"Update-start-menu" "Update startup-menu." \
    "Exit" "Exit back to CLI" 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $choice in
		Update-System)
		echo "User selected: " $choice
		sudo apt-get update && sudo apt-get upgrade
		;;
		Update-start-menu)
		echo "User selected: " $choice
		cd $HOME/start-menu
        git pull
        echo "startup-menu updtate finished"
        use_whiptail="False"
        exit
        start-menu
		;;
        Exit)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
		*)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
	esac
	done ## menu end
}


install_menu(){
	echo "Loading option list"
	option_list(){
    option1="RetroPie"
    option2="Kodi"
    option3="byobu"
    option_all="$option1 $option2 $option3"
    echo "Option list loaded."
    echo "containing $option_all"

    }

	echo "install menu"
## menu start
	while [ $use_whiptail = True ]
	do
	instll=$(whiptail --title "Install Menu" --menu "Choose an option" 25 78 16 \
	"List" "Select and install tools from a curated list." \
	"Custom" "install custom tools via apt-get." \
	"Exit" "Exit back to CLI" 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $instll in
		List)
		echo "User selected: " $instll
		;;
		Custom)
		echo "User selected: " $instll
        custom=$(whiptail --inputbox "Please specify the package name to install:" 8 78 synaptic --title "Install Dialog" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
    		echo "Ok, instaling:" $custom
    		sudo apt-get install $custom
		else
    		echo "User selected Cancel."
		fi
		;;
		Exit)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
		*)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
	esac
	done ## menu end
}

start_menu(){
	echo "start menu"
	## menu start
    while [ $use_whiptail = True ]
	do
	start=$(whiptail --title "Start Menu" --menu "Choose an option" 25 78 16 \
	"List" "Start tools fom curated list." \
	"Custom" "Start custom command if present." \
	"Exit" "Exit back to CLI" 3>&1 1>&2 2>&3)
	exitstatus=$?
	case $start in
		List)
		echo "User selected: " $start
		;;
		Custom)
		echo "User selected: " $start
        custom=$(whiptail --inputbox "Please specify the package name to install:" 8 78 synaptic --title "Install Dialog" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
    		echo "Ok, stating:" $custom
    		sudo apt-get install $custom
		else
    		echo "User selected Cancel."
		fi
		;;
		Exit)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
		*)
		echo "You cancelled or have finished."
		use_whiptail="False"
		exit
		;;
	esac
	done ## menu end
}
config
disclaimer