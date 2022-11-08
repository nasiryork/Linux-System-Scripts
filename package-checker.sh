#!/bin/bash
#title           :findpack.sh
#description     :This script informs the user if a selected package is installed on their machine.
#author          :Nasir York
#date            :07-31-2022
#version         :1.1.2
#==============================================================================

echo "enter a package you wish to check"
read pack;
#Searches for a package name and returns is status 
dpkg -s $pack | grep Status

exit
