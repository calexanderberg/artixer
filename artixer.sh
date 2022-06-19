#!/bin/bash

clear

# A script for installing Artix linux, an Arch based linux distribution.

#Variables
ENDMESSAGE="Thank you for using Artixer\nShutting down ... \n\nHave a great day"
TRUEPARTITION=false
BASESTRAP="base linux base-devel linux-firmware grub efibootmgr"

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
lsblk
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
echo -e "Adding openrc init system to the installer\n"

BASESTRAP = "${BASESTRAP}, openrc connman-openrc connman-gtk elogind-openrc"

echo -e "\nNow for desktop environment, select one from the list below:\n"
echo -e "Select 1 for kde"
echo -e "Select 2 for xfce4"
case $INITNUMBER in
	1)
		BASESTRAP = "${BASESTRAP} plasma"
		;;
	2)
		BASESTRAP = "${BASESTRAP} xfce4"
		;;
	*)
		echo -e "You did not select a desktop environment, that's ok";
	;;
esac

echo -e "Adding alacritty to our installer:"

BASESTRAP = "${BASESTRAP} alacritty"

echo -e "Adding firefox to our installer:"

BASESTRAP = "${BASESTRAP} firefox"

echo -e "Adding vim to our installer:"

BASESTRAP = "${BASESTRAP} vim"

echo -e "Done, begining install"

basestrap -i /mnt ${BASESTRAP}


echo -e "Install complete, now running all the commands to set up the system\n\n"

fstabgen -U /mnt >> /mnt/etc/fstab

artix-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
grub-install --recheck /dev/${mainPartition}
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "Adding the Swedish keyboard layout"
echo "KEYMAP=sv-latin1" >> /etc/vconsole.conf

echo -e "State a name for your machine"
read NAME
echo ${NAME} >> /etc/hostname
echo ${NAME} >> /etc/conf.d/hostname

echo -e "Setting up a root password"
passwd

echo -e "State a name for a user on your machine"
read USER
useradd -m -G wheel ${USER}
passwd ${USER}

echo -e "Time to get sudo privledge baby"
EDITOR=vim visudo

echo -e "installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay/

echo -e "installing all the B L O A T."

echo -e "Enabling all services we require."
rc-update add connmand
rc-update add sddm


echo -e "Rebooting the system"
exit
umount -R /mnt
reboot