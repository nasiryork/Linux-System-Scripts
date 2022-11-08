#!/usr/bin/bash
#title           :SSH_or_File_Transfer.sh
#description     :A Script to SSH and Transfer files to a remote machine.
#author          :Nasir York
#date            :09-18-2022
#version         :2.1.8
#==============================================================================

#Loops Script
while true; 
do

#Choose between Connecting to anothor machine via SSH, Transfering file between two machines, or Closing the script  
echo ""
echo "Would You like to connect to a remote machine or transfer A file?"
read -p "Type (Connect | Transfer | Quit): " choice
echo ""

case $choice in
Connect)
#Input for SSH 
echo "Its time to ssh into a remote machine"
read -p "(1/3) | First, can you enter the absolute path for your Public Key: " public_key_location
read -p "(2/3) | Can you enter the username of the server you would like to ssh into: " username
read -p "(3/3) | Lastly Can you enter the Public IP Address for the server/EC2: " ssh_ip

ssh -i $public_key_location $username@$ssh_ip
;;

Transfer)
#Choose the direction for the file transfer 
echo "You have selected file transfer"
read -p "(1/6) | Would you like to transfer from local to remote or remote to local? (l2r/r2l): " direction

#Inputs for Local to Remote file Transfer
if [ $direction == "l2r" ]; then
read -p "(2/6) | Can you enter the username of the remote server: " r_username
read -p "(3/6) | Can you enter the IP Address of the remote server: " ssh_ip
read -p "(4/6) | Enter the file path to your public key: " public_key_location
read -p "(5/6) | What is the path of the file you would like to transfer: " path_to_file
read -p "(6/6) | What file path would you like your file to be transfered to: " transfer_path

  sleep 2

  echo "transfering your file from local to remote"
  scp -i $public_key_location $path_to_file $r_username@$ssh_ip:$transfer_path
  sleep 2
  #Conformation if the file was succesfully transfered
  ssh -i $public_key_location $r_username@$ssh_ip -t "ls $transfer_path" && echo Transfer Complete, File Uploaded || echo Something Went Wrong, File Not Uploaded

#Inputs for Remote to Local file Transfer
elif [ $direction == "r2l" ]; then 
read -p "(2/6) | Can you enter the username of the remote server: " r_username
read -p "(3/6) | Can you enter the IP Address of the remote server: " ssh_ip
read -p "(4/6) | Enter the file path to your public key: " public_key_location
read -p "(5/6) | Enter the path of the file you want transfered from your remote machine: " remote_path_file 
read -p "(6/6) | Where on your local system would you like your file to be transfered to (local path): " local_path

sleep 2

  echo "transfering your file from remote to local"
  scp -i $public_key_location $r_username@$ssh_ip:$remote_path_file $local_path 
   
else [ $direction == "*" ]; 
  echo "Invaild Input"
  sleep 1
  echo "Try typing in either l2r or r2l"
  sleep 1
fi

;;

Quit)
exit 1
;;

*)
echo "Invalid Input"
echo "Try typing in either Connect or Transfer"
;;

esac

done