#!/bin/bash

name=$(cat $HOME/start-menu/config/tools/Desktop/name) # "Desktop"
packagename=$(cat $HOME/start-menu/config/tools/$name/packagename) # ""

sudo apt get update
sudo apt-get install $packagename
