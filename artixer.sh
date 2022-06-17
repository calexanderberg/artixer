#!/bin/bash

# A script for installing Artix linux, an Arch based linux distribution.

endMessage="Thank you for using Artixer\nShutting down ... \n\nHave a great day"

echo -e "Welcome to Artixer, an installer for Artix linux\n\n"
echo -e "In just a couple of minutes you will be able to one up, the \"I use
arch btw\" people \n\n"
echo -e "Remember this will erase any and all of your files. So stop here if 
you forgot something.\n\nAre you ready? [y/n]"

read decision

if [[ $decision == "yes" || $decision == "y" ]]; then
	
	echo -e "Awesome, let's get this started!\n\n"
else 
	echo -e "\nYou did not want to continue\n"
	echo -e "${endMessage}"
	exit 1
fi

echo -e "Below is a list of your partitions, please select which one to use.\n"
echo "lsblk"
read mainPartition
truePartition=false

while [ truePartition != true ]

do
	echo -e "\n\nYou selected ${mainPartition}, is this correct?"
	read decision
	
	if [[ $decision == "yes" || $decision == "y" ]]; then
		truePartition=true
		break;
	else
		echo -e "Please select a new partition."
		read mainPartition
	fi

done

echo -e "Awesome! How large do you want your boot parition to be? (in mb btw)"
read bootPart
echo -e "And your swap parition?"
read swapPart

# Do all the fdisk stuff, can't be bothered now

echo -e "Boot, swap, and root partition is done.\n\n"
echo -e "Let's go over some software.\n\n"
echo -e "Please select what init system to use"

echo -e "Select 1 for openrc"
# Make a variable for this instead otherwise it will be tedius
