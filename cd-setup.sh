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

echo -e "Installing 64bit only packages"
echo " "

sudo apt-get install g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-4.7-multilib g++-4.5-multilib

echo -e "${cya}Create the BIN folder{$txtrst}"
echo " "

mkdir -p ~/bin

echo -e "${cya}Download repo and setting permissions${txtrst}"
echo " "

curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

echo -e "${cya}Updating bashrc${txtrst}"
echo " "

$BASHCODE > ~/.bashrc

echo -e "${cya} Creating CyanDream folder${txtrst}"
echo " "

mkdir -p ~/cyandream/system

echo -e "${cya}Running repo init on CyanDream folder${txtrst}"
echo " "

cd ~/cyandream/system

repo init -u git://github.com/CyanDreamProject/android.git -b cd-4.4

echo -e "${cya}Grabbing the build file${txtrst}"
echo " "
curl -O https://raw.github.com/AndyFox2013/scripts/master/build.sh

echo -e "${red}Running repo sync${txtrst}"

repo sync -j4