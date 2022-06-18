#!/bin/bash

# A script for installing Artix linux, an Arch based linux distribution.

#Variables
ENDMESSAGE="Thank you for using Artixer\nShutting down ... \n\nHave a great day"
TRUEPARTITION=false
BASESTRAP="base linux base-devel linux-firmware"

# Startup message
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
	echo -e "${ENDMESSAGE}"
	exit 1
fi


# Choosing your boot partition
echo -e "Below is a list of your partitions, please select which one to use.\n"
echo "lsblk"
read mainPartition

while [ TRUEPARTITION != true ]

do
	echo -e "\n\nYou selected ${mainPartition}, is this correct?"
	read decision
	
	if [[ $decision == "yes" || $decision == "y" ]]; then
		TRUEPARTITION=true
		break;
	else
		echo -e "Please select a new partition."
		read mainPartition
	fi

done

echo -e "Awesome! How large do you want your boot parition to be? (in mb)"
read bootPart
echo -e "And your swap parition?"
read swapPart

# Do all the fdisk stuff, can't be bothered to implement it now

echo -e "Boot, swap, and root partition is done.\n\n"
echo -e "Let's go over some software.\n\n"
echo -e "Please select what init system to use"

echo -e "Select 1 for openrc"
echo -e "Select 2 for runit"
echo -e "Select 3 for s6"
echo -e "Select 4 for 66"
# echo -e "Select 5 for dinit" - We will add this later
read INITNUMBER
# Make a variable for this instead otherwise it will be tedius


case $INITNUMBER in
	1)
		BASESTRAP = "${BASESTRAP} openrc elogind-openrc sddm-openrc connman-openrc connman-gtk"
		;;
	2)
		BASESTRAP = "${BASESTRAP} runit elogind-runit sddm-runit connman-runit connman-gtk"
		;;
	3)
		BASESTRAP = "${BASESTRAP} s6-base elogind-s6 sddm-s6 connman-s6 connman-gtk"
		;;
	4)
		BASESTRAP = "${BASESTRAP} 66 elogind-suite66 sddm-suite66 connman-suite66 connman-gtk"
		;;
	*)
		echo -e "Please select a number within 1-5";
		read INITNUMBER
		#I think this will not work but we will fix it later
	;;
esac

echo -e "\nNow for desktop environment, select one from the list below:\n"
echo -e "Select 1 for kde"
echo -e "Select 2 for mate (and other applications)"
echo -e "Select 3 for xfce4"
echo -e "Select 4 for lxqt" 
case $INITNUMBER in
	1)
		BASESTRAP = "${BASESTRAP} plasma"
		;;
	2)
		BASESTRAP = "${BASESTRAP} mate mate-extra system-config-printer blueman connman-gtk"
		;;
	3)
		BASESTRAP = "${BASESTRAP} xfce4"
		;;
	4)
		BASESTRAP = "${BASESTRAP} lxqt"
		;;
	*)
		echo -e "You did not select a desktop environment, that's ok";
	;;
esac

