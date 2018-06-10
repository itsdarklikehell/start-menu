#!/bin/bash
menu(){
	configure(){
		name=$(whiptail --inputbox "Please specify the NAME for the application" 8 78 Default --title "Name" 3>&1 1>&2 2>&3)
		#whiptail --title "Confimation:" --msgbox "name is set to $name" 8 78
		command=$(whiptail --inputbox "Please specify the COMMAND for the applicaton" 8 78 $name --title "command" 3>&1 1>&2 2>&3)
		#whiptail --title "Confimation:" --msgbox "command is set to $command" 8 78
		description=$(whiptail --inputbox "Please give a brief DESCRIPTION of the applicaton" 8 78 $name --title "description" 3>&1 1>&2 2>&3)
		#whiptail --title "Confimation:" --msgbox "description is set to $description" 8 78
		packagename=$(whiptail --inputbox "Please specify the PACKAGENAME for the applicaton" 8 78 $name --title "packagename" 3>&1 1>&2 2>&3)
		#whiptail --title "Confimation:" --msgbox "packagename is set to $packagename" 8 78
		}
		make_runfiles(){
			conf_dir=$HOME/start-menu/config/tools/$name
			info_dir=$conf_dir/info
			make_info(){
				#whiptail --title "creating $info_dir" --msgbox "creating $info_dir for $name" 8 78
				mkdir -p $info_dir
				#whiptail --title "creating info files" --msgbox "creating info files for $name in $info_dir" 8 78
				echo $name > $info_dir/name
				echo $command >> $info_dir/command
				echo $description >> $info_dir/description
				echo $packagename >> $info_dir/packagename
				}
			make_start(){
				#whiptail --title "creating start.sh" --msgbox "creating start.sh for $name in $conf_dir." 8 78
				echo "#!/bin/bash" > $conf_dir/start.sh
				echo "name=$(cat $HOME/start-menu/config/tools/$name/info/name)" >> $conf_dir/start.sh
				echo "command=$(cat $HOME/start-menu/config/tools/$name/info/command)" >> $conf_dir/start.sh
				echo "bash $command" >> $conf_dir/start.sh
				}
			make_install(){
				#whiptail --title "creating install.sh" --msgbox "creating install.sh for $name in $conf_dir." 8 78
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
					#whiptail --title "creating backup of $startlist" --msgbox "creating backup of $startlist in $backupfile." 8 78
					cp $startlist $backupfile
					#whiptail --title "creating $tmpfile" --msgbox "creating $tmpfile containing info for $name." 8 78
					cp $startlist $tmpfile
					if [[ ! -z $(grep "$name" "$tmpfile") ]];
					then
					whiptail --title "Entry FOUND skipping..." --msgbox "Entry for $name FOUND skipping..." 8 78
					else
					source $startlist
					number=$((number+1))
					echo "" >> $tmpfile
					echo "option_$number(){" >> $tmpfile
					echo "option_number=$number" >> $tmpfile
					echo "name=$name" >> $tmpfile
					echo "command=$command" >> $tmpfile
					echo "description=$description" >> $tmpfile
					echo "packagename=$packagename" >> $tmpfile
					echo "}" >> $tmpfile
					echo "option_$number" >> $tmpfile
					echo "number=$number" >> $tmpfile
					whiptail --title "creating new $startlist" --msgbox "creating new $startlist from $tmpfile containing $number entries." 8 78
					cp $tmpfile $startlist
					fi
					#whiptail --title "removing $tmpfile" --msgbox "removing $tmpfile" 8 78
					rm $tmpfile
					}
				add_to_installlist(){
					installlist=$HOME/start-menu/config/install_tool.list
					backupfile=$installlist.old
					tmpfile=/tmp/install_tool.list.tmp
					#whiptail --title "creating backup of $installlist" --msgbox "creating backup of $installlist in $backupfile." 8 78
					cp $installlist $backupfile
					#whiptail --title "creating $tmpfile" --msgbox "creating $tmpfile containing info for $name." 8 78
					cp $installlist $tmpfile
					if [[ ! -z $(grep "$name" "$tmpfile") ]]; then
					whiptail --title "Entry FOUND skipping..." --msgbox "Entry for $name FOUND skipping..." 8 78
					else
					source $installlist
					number=$((number+1))
					echo "" >> $tmpfile
					echo "option_$number(){" >> $tmpfile
					echo "option_number=$number" >> $tmpfile
					echo "name=$name" >> $tmpfile
					echo "command=$command" >> $tmpfile
					echo "description=$description" >> $tmpfile
					echo "packagename=$packagename" >> $tmpfile
					echo "}" >> $tmpfile
					echo "option_$number" >> $tmpfile
					echo "number=$number" >> $tmpfile
					whiptail --title "creating new $installist" --msgbox "creating new $installist from $tmpfile containing $number entries." 8 78
					cp $tmpfile $installlist
					fi
					
					#whiptail --title "removing $tmpfile" --msgbox "removing $tmpfile" 8 78
					rm $tmpfile
					}
				add_to_startlist
				add_to_installlist
				}

make_start_tools_menu(){
	start_tools_menu=$HOME/start-menu/config/tools/start_tools_menu.sh
	tmpfile=/tmp/start_tools_menu.sh
	
echo '#!/bin/bash' > $tmpfile
echo 'choice=$(whiptail --title "Start Tool List" --radiolist \' >> $tmpfile
echo '"Select tool to start" 20 78 4 \' >> $tmpfile

echo "'$name' '$description' ON 3>&1 1>&2 2>&3)" >> $tmpfile

echo 'case $choice in' >> $tmpfile

echo "	$name)" >> $tmpfile
echo '	echo "User selected: " $choice' >> $tmpfile
echo "    name=$name" >> $tmpfile
echo '    bash $HOME/start-menu/config/tools/$name/start.sh' >> $tmpfile
echo '    ;;' >> $tmpfile

echo '	*)' >> $tmpfile
echo '	echo "You cancelled or have finished."' >> $tmpfile
echo '	;;' >> $tmpfile
echo 'esac' >> $tmpfile
cp $tmpfile $start_tools_menu
rm $tmpfile
chmod +x $start_tools_menu
bash $start_tools_menu
	}

#make_install_tools_menu(){}


make_info
make_start
make_install
make_list
make_start_tools_menu
#make_install_tools_menu

whiptail --title "Creation complete" --msgbox "runfile creation for $name in $conf_dir is completed." 8 78
if (whiptail --title "Add another>" --yesno "Do you want to make another entry?" 8 78) then
    menu
else
    echo "User selected No, exit status was $?."
fi
}
configure
make_runfiles
}
menu
