#!/bin/bash
menu(){
configure(){
conf_dir=$HOME/start-menu/config/tools/$name
info_dir=$conf_dir/info

name=$(whiptail --inputbox "Please specify the NAME for the application" 8 78 --title "Name" 3>&1 1>&2 2>&3)
whiptail --title "Confimation:" --msgbox "name is set to $name" 8 78

command=$(whiptail --inputbox "Please specify the COMMAND for the applicaton" 8 78 --title "command" 3>&1 1>&2 2>&3)
whiptail --title "Confimation:" --msgbox "command is set to $command" 8 78

description=$(whiptail --inputbox "Please give a brief DESCRIPTION of the applicaton" 8 78 --title "description" 3>&1 1>&2 2>&3)
whiptail --title "Confimation:" --msgbox "description is set to $description" 8 78

packagename=$(whiptail --inputbox "Please specify the PACKAGENAME for the applicaton" 8 78 --title "packagename" 3>&1 1>&2 2>&3)
whiptail --title "Confimation:" --msgbox "packagename is set to $packagename" 8 78
}
make_runfiles(){
make_info(){
whiptail --title "creating '$info_dir'" --msgbox "creating '$info_dir' for '$name'" 8 78
mkdir -p $info_dir
whiptail --title "creating info files" --msgbox "creating info files for $name in $info_dir" 8 78
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
make_list(){
add_to_startlist(){
startlist=$HOME/start-menu/config/start_tool.list
backupfile=$startlist.old
tmpfile=/tmp/start_tool.list.tmp

whiptail --title "creating backup of $startlist" --msgbox "creating backup of $startlist in $backupfile." 8 78
cp $startlist $backupfile

whiptail --title "creating $tmpfile" --msgbox "creating $tmpfile containing info for $name." 8 78
cat $startlist > $tmpfile
echo "$name(){"
echo "name=$name" >> $tmpfile
echo "comamand=$command" >> $tmpfile
echo "description=$description" >> $tmpfile
echo "packagename=$packagename" >> $tmpfile
echo "}" >> $tmpfile
echo "$name" >> $tmpfile

whiptail --title "creating new $startlist" --msgbox "creating new $startlist from $tmpfile" 8 78
cp $tmpfile $startlist
whiptail --title "removing $tmpfile" --msgbox "removing $tmpfile" 8 78
rm $tmpfile
}
add_to_installlist(){
installlist=$HOME/start-menu/config/install_tool.list
backupfile=$installlist.old
tmpfile=/tmp/install_tool.list.tmp

whiptail --title "creating backup of $installlist" --msgbox "creating backup of $installlist in $backupfile." 8 78
cp $installlist $backupfile

whiptail --title "creating $tmpfile" --msgbox "creating $tmpfile containing info for $name." 8 78
cat $installlist > $tmpfile
echo "$name(){"
echo "name=$name" >> $tmpfile
echo "comamand=$command" >> $tmpfile
echo "description=$description" >> $tmpfile
echo "packagename=$packagename" >> $tmpfile
echo "}" >> $tmpfile
echo "$name" >> $tmpfile

whiptail --title "creating new $installist" --msgbox "creating new $installist from $tmpfile" 8 78
cp $tmpfile $installlist
whiptail --title "removing $tmpfile" --msgbox "removing $tmpfile" 8 78
rm $tmpfile
}
}

make_info
make_start
make_install
make_list
whiptail --title "Creation complete" --msgbox "runfile creation for $name in $conf_dir is completed." 8 78
}

configure
make_runfiles
}



menu