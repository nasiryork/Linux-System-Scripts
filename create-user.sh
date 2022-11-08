#!/bin/bash
#title           :create-user.sh
#description     :This script creates a New User and sets their group, shell, and password.
#author          :Nasir York
#date            :08-5-2022
#version         :1.3.2
#==============================================================================
#Checks if the user running the script is a Super User
if [ $UID != 0 ];
then echo "Superuser only!!";
exit
fi

#Obtains information for a new User
echo "Enter your First Name, Last Name, Shell, Group, and Password on different lines"
read fName;
read lName;
read shell;
read group;
read pass;

#Convers the First and Last name into a single string
firstlet=${fName::1}
nameComb="$firstlet$lName";
usname=$nameComb

# Creates a group name if it is not already taken
groupadd $group

#Creats the new User
useradd -g $group -s $shell $usname

echo "$usname:$pass | chpasswd"

exit 1
