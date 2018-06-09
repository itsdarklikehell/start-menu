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

load_start_tool_list(){
source $HOME/start-menu/config/start_tools.list

	option1="Desktop"
    description1="Raspbian desktop."
    option2="Emulationstation"
    description2="Emulationstation frontend."
    option3="Kodi"
    description3="bKodi mediacentre."
    option4="byobu"
    description4="byobu shell."
    option_all="$option1 $option2 $option3"
    echo "Option list loaded."
    echo "containing $option_all"
}

load_install_tool_list(){
source $HOME/start-menu/config/install_tools.list

	option1="Emulationstation"
    description1="Emulationstation/retropie."
    option2="Kodi"
    description2="Kodi mediacentre."
    option3="byobu"
    description3="byobu shell."
    option_all="$option1 $option2 $option3"
    echo "Option list loaded."
    echo "containing $option_all"
}

start_done(){
	echo "Finished starting: $choice"
	whiptail --title " Dialog" --msgbox "Finished starting: $choice." 8 78
}

install_done(){
	echo "Finished instaling: $choice"
	whiptail --title " Dialog" --msgbox "Finished installing: $choice." 8 78
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
echo "options menu"
	## menu start
    while [ $use_whiptail = True ]
	do
	choice=$(whiptail --title "Option Menu" --menu "Choose an option" 25 78 16 \
	"Update-System" "Update system." \
	"Update-start-menu" "Update startup-menu." \
    "Raspi-Config" "Configure raspbian." \
    "RetroPie-Setup" "Configure Retropie." \
    "Exit" "Exit back to CLI" 3>&1 1>&2 2>&3)
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
        Raspi-Config)
		echo "User selected: " $choice
		sudo raspi-config
		;;
        RetroPie-Setup)
		echo "User selected: " $choice
        sudo $HOME/RetroPie-Setup/retropie_setup.sh
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
echo "User selected: " $choice
load_start_tool_list
choice=$(whiptail --title "Start Tool" --radioist \
"Select tool to start" 20 78 4 \
"$option1" "$description1" ON \
"$option2" "$description2" Off 3>&1 1>&2 2>&3)
}

install_list_menu(){
echo "User selected: " $choice
load_install_tool_list
choice=$(whiptail --title "Install Tool" --checklist \
"Select tool to install" 20 78 4 \
"$option1" "$description1" ON \
"$option2" "$description2" ON 3>&1 1>&2 2>&3)
}

config
disclaimer