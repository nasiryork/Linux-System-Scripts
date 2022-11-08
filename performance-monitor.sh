#!/bin/bash
#title           :performance-monitor.sh
#description     :This script prompts the user with the option to terminate a prosses once it passes a set threshold
#author          :Nasir York
#date            :08-11-2022
#version         :1.2.3
#potential errors:In order to start the termination process the only characters that works is lowercase y
#==============================================================================

#Program ID for the top process
propid=$(ps -o %mem,pid | sort -bnr -k1 | head -n 1 | awk '/[0-9]*/{print $1 ":" $2}' | cut -d":" -f2)

#Program Name of the top process
program=$(ps -o %mem,command ax | sort -bnr -k1 | head -n 1 | awk '/[0-9]*/{print $1 ":" $2}' | cut -d":" -f2)

#Shows how much memory is being used by the top proccess
memUse=$(ps -o %mem,command ax | sort -bnr -k1 | head -n 1 | awk '/[0-9]*/{print $1 ":" $2}' | cut -d":" -f1)

#Truncates the Memory Use decimal
floor=$(printf "%.0f\n" $memUse)

#Enter memory threshold in %
memTH=3 # 30%

if [ $floor -ge $memTH ];
   then
      read -p "Process $program is taking up $memUse % of memory, would you like to teminate it {y/n}" ans
        if [ $ans = "y" ];
         then
           kill -9 $propid
        fi

else
    echo "Memory is running smoothly"

fi

exit
