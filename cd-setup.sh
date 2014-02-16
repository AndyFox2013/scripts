#!/bin/bash

# get current path
reldir=`dirname $0`
cd $reldir
DIR=`pwd`

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

THREADS="16"
DEVICE="$1"
SYNC="$2"

BASHCODE="export PATH=${PATH}:~/bin"


echo -e "${cya}CyanDream Setup Script${txtrst}"
echo " "

echo -e "Installing packages required to compile"
echo -e "${red}Please enter password when prompted${txtrst}"
echo " "

sudo apt-get install git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-6-jre openjdk-6-jdk pngcrush schedtool
sleep 5

echo -e "Installing 64bit only packages"
echo " "

sudo apt-get install g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-4.7-multilib g++-4.5-multilib
sleep 5

echo -e "${cya}Create the BIN folder{$txtrst}"
echo " "

mkdir -p ~/bin

echo -e "${cya}Download repo and setting permissions${txtrst}"
echo " "

curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo
sleep 2

echo -e "${cya}Updating bashrc${txtrst}"
echo " "

$BASHCODE >> ~/.bashrc
sleep 2
export PATH=${PATH}:~/bin

echo -e "${cya} Creating CyanDream folder${txtrst}"
echo " "

mkdir -p ~/cyandream/system

echo -e "${cya}Running repo init on CyanDream folder${txtrst}"
echo " "

cd ~/cyandream/system

repo init -u git://github.com/CyanDreamProject/android.git -b cd-4.4
sleep 5

echo -e "${cya}Grabbing the build file${txtrst}"
echo " "
curl -O https://raw.github.com/AndyFox2013/scripts/master/build.sh
chmod a+x build.sh
sleep 5

echo -e "${cya}Do you want to sync now? (y/n)${txtrst}"

read SYNC

	if  [ $SYNC  ==  y ] ; then
	
		echo -e "${red}Running repo sync${txtrst}"
		repo sync -j4
		sleep 5
		
	elif [ $SYNC  ==  n ] ; then
		echo -e "${red} Not syncing now${txtrst}"
		sleep 2
		
	fi
	
echo -e "${cya} use './build.sh' to sync and compile${txtrst}"



