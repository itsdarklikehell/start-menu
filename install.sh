#!/bin/bash
installdir=$HOME/start-menu
echo "installing start-menu"
sudo ln -s $installdir/start-menu.sh /usr/local/bin/start-menu
start-menu

