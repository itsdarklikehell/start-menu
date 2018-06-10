#echo "User selected: " $choice



entries=$(cat $HOME/start-menu/config/start_tool_menu_entries.txt)
echo "$entries"

choice=$(whiptail --title "Start Tool List" --radiolist \
"Select tool to start" 20 78 4 \
"Desktop" "Raspbian Pixel Desktop." ON \
$entries 3>&1 1>&2 2>&3)

case $choice in
	Desktop)
	echo "User selected: " $choice
    name="Desktop"
    bash $HOME/start-menu/config/tools/$name/start.sh
    ;;
	#*)
	#echo "You cancelled or have finished."
	#;;
esac
