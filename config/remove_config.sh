#!/bin/bash
name=$(whiptail --inputbox "Please specify the NAME for the application to remove" 8 78 --title "Name" 3>&1 1>&2 2>&3)


packagename=$(whiptail --inputbox "Please specify the PACKAGENAME for the applicaton" 8 78 --title "packagename" 3>&1 1>&2 2>&3)
conf_dir="$HOME/start-menu/config/tools/$name"
info_dir="$conf_dir/info"

remove_runfiles(){
remove_info(){
whiptail --title "removing info files" --msgbox "removing info files for $name in $info_dir." 8 78
rm $info_dir/name
rm $info_dir/command
rm $info_dir/description
rm $info_dir/packagename
whiptail --title "removing $info_dir" --msgbox "removing $info_dir for $name." 8 78
rm -rf $info_dir
}
remove_start(){
whiptail --title "removing start.sh" --msgbox "removing start.sh for $name in $conf_dir." 8 78
rm $conf_dir/start.sh
}
remove_install(){
whiptail --title "removing install.sh" --msgbox "removing install.sh for $name in $conf_dir." 8 78
rm $conf_dir/install.sh
}
remove_info
remove_start
remove_install
rm -rf $conf_dir
whiptail --title "remove complete" --msgbox "runfile remove for $name from $conf_dir is completed." 8 78
}
remove_runfiles
