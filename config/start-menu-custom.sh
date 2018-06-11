#!/bin/bash
start_done(){
	echo "Finished starting: $choice"
	whiptail --title " Finished Starting" --msgbox "Finished starting: $choice." 8 78
}

echo "User selected: " $choice
        choice=$(whiptail --inputbox "Please specify the command to run:" 8 78 synaptic --title "Custom comand Dialog" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
    		echo "Ok, stating:" $choice
    		$choice
            start_done
		else
    		echo "User selected Cancel."
		fi