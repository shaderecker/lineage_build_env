#!/bin/bash

exec > setup.log 2>&1

trap 'exit 130' INT

source settings.sh

echo Starting unattended Setup for LineageOS Build Environment...

cd ~/

echo Updating sources...
sudo apt-get update
echo Updating sources finished.

echo Upgrading packages...
sudo apt-get upgrade -y --allow-unauthenticated
echo Upgrading packages finished.

echo Cleaning up...
sudo apt-get autoremove -y
echo Cleanup finished.

echo Installing needed packages...
sudo apt-get install -y bc bison build-essential curl flex git gnupg gperf libesd0-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop maven openjdk-8-jdk pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev g++-multilib gcc-multilib lib32ncurses5-dev lib32readline6-dev lib32z1-dev imagemagick
echo Installing packages finished.

echo Setting global gitconfig
git config --global user.name "$git_name" #Specify in settings
git config --global user.email "$git_email" #Specify in settings
git config --global color.ui true

echo Making directories
mkdir -p ~/bin
mkdir -p ~/android/lineageos/

echo Curling repo
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo Initializing repo
cd ~/android/lineageos/

repo init -u git://github.com/lineageos/android.git -b cm-14.1

cd ~/android/lineageos/.repo
rm -rf local_manifests
git clone https://github.com/TheHADILP/local_manifests.git
cd ~/android/lineageos/

echo Syncing repo
repo sync --force-sync

echo envsetup
cd ~/android/lineageos

source build/envsetup.sh

echo Breakfast new device #Specify in settings
breakfast $device

#echo Now we need some repository for getting vendor files #Specify in settings
#cd ~/android/lineageos/vendor
#mkdir -p $path
#mkdir -p temp
#cd ~/android/lineageos/vendor/$path
#git clone $vendor           #This whole bunch should pbb go into roomservice.xml for continuous updates
#cp -r ~/android/lineageos/vendor/$path/*/. ~/android/lineageos/vendor/temp
#cd ~/android/lineageos/vendor
#rm -rf ~/android/lineageos/vendor/$path
#mkdir -p $path
#cp -r ~/android/lineageos/vendor/temp/. ~/android/lineageos/vendor/$path
#rm -rf ~/android/lineageos/vendor/temp
#
#echo Repeating breakfast after vendor files in case sth went wrong previously
#breakfast $device

echo Setting up environment variables...
export USE_CCACHE=1
export ANDROID_CCACHE_SIZE="$ccache"
#export USE_NINJA=false
#export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx$ram"
export WITH_SU=true

echo Printing environment variables...
printenv

echo Cleaning...
cd ~/android/lineageos
make clean

echo Repopicking...
repopick -f -t i9300-personal-build

echo Starting build...
brunch i9300
