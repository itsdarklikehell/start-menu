#!/bin/bash
name=$(whiptail --inputbox "Please specify the NAME for the application" 8 78 --title "Name" 3>&1 1>&2 2>&3)
command=$(whiptail --inputbox "Please specify the COMMAND for the applicaton" 8 78 --title "command" 3>&1 1>&2 2>&3)
description=$(whiptail --inputbox "Please give a brief DESCRIPTION of the applicaton" 8 78 --title "description" 3>&1 1>&2 2>&3)
packagename=$(whiptail --inputbox "Please specify the PACKAGENAME for the applicaton" 8 78 --title "packagename" 3>&1 1>&2 2>&3)
conf_dir="$HOME/start-menu/config/tools/$name"
info_dir="$conf_dir/info"

make_runfiles(){
make_info(){
whiptail --title "creating $info_dir" --msgbox "creating $info_dir for $name." 8 78
mkdir -p $info_dir
whiptail --title "creating info files" --msgbox "creating info files for $name in $info_dir." 8 78
echo $name > $info_dir/name
echo $command >> $info_dir/command
echo $description >> $info_dir/description
echo $packagename >> $info_dir/packagename
}
make_start(){
whiptail --title "creating start.sh" --msgbox "creating start.sh for $name in $conf_dir." 8 78
echo "#!/bin/bash" > $conf_dir/start.sh
echo "name=$(cat $HOME/start-menu/config/tools/$name/info/name)" >> $conf_dir/start.sh
echo "command=$(cat $HOME/start-menu/config/tools/$name/info/command)" >> $conf_dir/start.sh
echo "bash $command" >> $conf_dir/start.sh
}
make_install(){
whiptail --title "creating install.sh" --msgbox "creating install.sh for $name in $conf_dir." 8 78
echo "#!/bin/bash" > $conf_dir/install.sh
echo "name=$(cat $HOME/start-menu/config/tools/$name/info/name)" >> $conf_dir/install.sh
echo "sudo apt get update" >> $conf_dir/install.sh
echo "sudo apt-get install $packagename" >> $conf_dir/install.sh
}
make_info
make_start
make_install
whiptail --title "Creation complete" --msgbox "runfile creation for $name in $conf_dir is completed." 8 78
}
make_runfiles
