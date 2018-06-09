#!/bin/bash
name=$(cat $HOME/start-menu/config/tools/Desktop/name) # "Desktop"
exec_command=$(cat $HOME/start-menu/config/tools/$name/info/command) #or use hardcode like "Execname -S"

bash $exec_command
