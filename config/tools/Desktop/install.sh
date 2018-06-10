#!/bin/bash

name=$(cat $HOME/start-menu/config/tools/Desktop/info/name) # "Desktop"
packagename=$(cat $HOME/start-menu/config/tools/$name/info/packagename) # ""

sudo apt get update
sudo apt-get install $packagename
