#!/bin/bash
#Startup menu for RPI made by itsdarklikehell.

config(){
	use_whiptail="True"
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

	option_list(){
    option1="RetroPie"
    option2="Kodi"
    option3="byobu"
    option_all="$option1 $option2 $option3"

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