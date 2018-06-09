#!/bin/bash
#name=$(cat $HOME/start-menu/config/tools/Desktop/info/name) # "Desktop"
exec_command=$(cat $HOME/start-menu/config/tools/Desktop/info/command) #or use hardcode like "Execname -S"

bash $exec_command
