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
				startorinstall="start"
					#whiptail --title "creating start.sh" --msgbox "creating start.sh for $name in $conf_dir." 8 78
				echo "#!/bin/bash" > $conf_dir/$startorinstall.sh
				echo "name=$(cat $HOME/start-menu/config/tools/$name/info/name)" >> $conf_dir/$startorinstall.sh
				echo "command=$(cat $HOME/start-menu/config/tools/$name/info/command)" >> $conf_dir/$startorinstall.sh
				echo "bash $command" >> $conf_dir/$startorinstall.sh
				}
			make_install(){
            startorinstall="install"
				#whiptail --title "creating install.sh" --msgbox "creating install.sh for $name in $conf_dir." 8 78
				echo "#!/bin/bash" > $conf_dir/$startorinstall.sh
				echo "name=$(cat $HOME/start-menu/config/tools/$name/info/name)" >> $conf_dir/startorinstall.sh
				echo "sudo apt get update" >> $conf_dir/startorinstall.sh
				echo "sudo apt-get install $packagename" >> $conf_dir/startorinstall.sh
				}
			make_list(){

            make_tools_menu(){
	tools_menu=$HOME/start-menu/config/tools/$startorinstall_tools_menu.sh
	tmpfile=/tmp/$startorinstall_tools_menu.sh
header(){
	echo "#!/bin/bash" > $tmpfile
	echo 'choice=$(whiptail --title "$startorinstall Tool List" --radiolist \\' >> $tmpfile
	echo '"Select tool to $startorinstall" 20 78 4 \\' >> $tmpfile
}
entry(){
	echo "'$name' '$description' ON \\" >> $tmpfile
}
footer(){
	echo "'Exit' 'Exit to CLI.' ON 3>&1 1>&2 2>&3)" >> $tmpfile
	echo 'case $choice in' >> $tmpfile
}
response(){
	echo "	$name)" >> $tmpfile
	echo '	echo "User selected: " $choice' >> $tmpfile
	echo "    name=$name" >> $tmpfile
	echo '    bash $HOME/start-menu/config/tools/$name/$startorinstall.sh' >> $tmpfile
	echo '    ;;' >> $tmpfile
}
ending(){
	echo '	*)' >> $tmpfile
	echo '	echo "You cancelled or have finished."' >> $tmpfile
	echo '	;;' >> $tmpfile
	echo '	Exit)' >> $tmpfile
	echo '	echo "You cancelled or have finished."' >> $tmpfile
	echo '	;;' >> $tmpfile
	echo 'esac' >> $tmpfile
}
header
entry
footer
response
ending

cp $tmpfile $startorinstall_tools_menu
rm $tmpfile
chmod +x $startorinstall_tools_menu
#bash $start_tools_menu
}
				add_to_startlist(){
                	startorinstall="start"
					$startorinstalllist=$HOME/start-menu/config/$startorinstall_tool.list
					backupfile=$startorinstalllist.old
					tmpfile=/tmp/$startorinstall_tool.list.tmp
					#whiptail --title "creating backup of $startlist" --msgbox "creating backup of $startlist in $backupfile." 8 78
					cp $startorinstall $backupfile
					#whiptail --title "creating $tmpfile" --msgbox "creating $tmpfile containing info for $name." 8 78
					cp $startorinstall $tmpfile
					if [[ ! -z $(grep "$name" "$tmpfile") ]];
					then
					whiptail --title "Entry FOUND skipping..." --msgbox "Entry for $name FOUND skipping..." 8 78
					else
					source $startorinstalllist
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
					cp $tmpfile $startorinstall
					make_tools_menu
                    fi
					#whiptail --title "removing $tmpfile" --msgbox "removing $tmpfile" 8 78
					rm $tmpfile
					}
				add_to_installlist(){
                startorinstall="install"
					$startorinstalllist=$HOME/start-menu/config/$startorinstall_tool.list
					backupfile=$startorinstalllist.old
					tmpfile=/tmp/$startorinstall_tool.list.tmp
					#whiptail --title "creating backup of $installlist" --msgbox "creating backup of $installlist in $backupfile." 8 78
					cp $startorinstalllist $backupfile
					#whiptail --title "creating $tmpfile" --msgbox "creating $tmpfile containing info for $name." 8 78
					cp $startorinstalllist $tmpfile
					if [[ ! -z $(grep "$name" "$tmpfile") ]]; then
					whiptail --title "Entry FOUND skipping..." --msgbox "Entry for $name FOUND skipping..." 8 78
					else
					source $startorinstalllist
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
					whiptail --title "creating new $startorinstalllist" --msgbox "creating new $$startorinstalllist from $tmpfile containing $number entries." 8 78
					cp $tmpfile $startorinstalllist
					make_tools_menu
                    fi

					#whiptail --title "removing $tmpfile" --msgbox "removing $tmpfile" 8 78
					rm $tmpfile
					}
				add_to_startlist
				add_to_installlist

				}

make_info
make_start
make_install
make_list

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