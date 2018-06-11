#!/bin/bash
install_done(){
	echo "Finished instaling: $choice"
	whiptail --title " Finished Installing" --msgbox "Finished installing: $choice." 8 78
}
        choice=$(whiptail --inputbox "Please specify the package to install:" 8 78 synaptic --title "Custom install Dialog" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
    		echo "Ok, instaling:" $choice
    		sudo apt-get install $choice
            install_done
		else
    		echo "User selected Cancel."
		fi