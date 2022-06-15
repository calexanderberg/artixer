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
	echo -e "Below is a list of your partitions, please select which one to use.\n\n"
	lsblk	
	echo ""
	read mainPartition
	echo -e "\n\nYou selected ${mainPartition}, is this correct?"

	
	
else 
	echo -e "\nYou did not want to continue\n"
	echo -e "${endMessage}"
	exit 1
fi
