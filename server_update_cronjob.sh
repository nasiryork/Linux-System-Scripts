#!/bin/bash
#title           :server_update_cronjob.sh
#description     :This script updates and upgrades a linux system then writes a log file that includes pacages that were changed.
#author          :Nasir York
#date            :07-31-2022
#version         :1.1.3
#cronjob         :#0 23 * * 5 root /home/nasir/bin/server_update_cronjob.sh 
#notes           :Update every Friday at 11:00pm
#==============================================================================

apt update;
sleep 1
apt-get upgrade >> /home/nasir/Desktop/Server_Log/"$(date +"%d_%m_%Y_%I_%M")_Server_Update.log"
