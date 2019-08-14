#!/bin/bash

# Force default language for output (for 18.04)
export LC_ALL=C

# Import settings
source settings.sh

# Disable update dialogues
export DEBIAN_FRONTEND=noninteractive

if ! grep -q confdef /etc/apt/apt.conf.d/50unattended-upgrades; then
echo "Dpkg::Options {
        "--force-confdef";
        "--force-confold";
      }" | sudo tee -a  /etc/apt/apt.conf.d/50unattended-upgrades
fi

# Add Ubuntu Xenial sources
if ! grep -q xenial /etc/apt/sources.list; then
echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial main universe
deb-src http://us.archive.ubuntu.com/ubuntu/ xenial main universe" | sudo tee -a /etc/apt/sources.list
fi

# Install banner packages
sudo apt install -y figlet toilet boxes

# Banner function
function losBANNER {
  toilet -f ivrit "$1" | boxes -d stone
}

losBANNER "LineageOS"
echo
losBANNER "Build: $device"

cd ~/

# Update installed packages
echo
echo
losBANNER "Updating..."
sudo apt update
sudo apt upgrade -y --allow-unauthenticated
sudo apt autoremove -y

# Install new required packages
losBANNER "Installing..."
sudo apt install -y bc bison build-essential curl flex git gnupg gperf libesd0-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop maven openjdk-8-jdk pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev g++-multilib gcc-multilib lib32ncurses5-dev lib32readline-dev lib32z1-dev imagemagick python

# Set gitconfig
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global color.ui true

# Create directories
mkdir -p ~/bin
mkdir -p ~/android/lineageos/

# Install repo tool
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Initialize repo
cd ~/android/lineageos/
repo init -u git://github.com/lineageos/android.git -b $lineage_version

# Switch to our custom local_manifest
if [[ $custom_local_manifest = "true" ]]
then
cd ~/android/lineageos/.repo
rm -rf local_manifests
git clone $custom_local_manifest_url
cd ~/android/lineageos/
fi

# Sync repo
losBANNER "Syncing Repo..."
repo sync --force-sync

# Environment setup
source build/envsetup.sh

losBANNER "Init: $device"
# Initialize our device
breakfast $device

# Get device specific vendor files
if [[ $custom_local_manifest != "true" ]]
then
cd ~/android/lineageos/vendor
mkdir -p $vendor_path
mkdir -p temp
cd ~/android/lineageos/vendor/$vendor_path
git clone $vendor_files_git
cp -r ~/android/lineageos/vendor/$vendor_path/*/* ~/android/lineageos/vendor/temp
cd ~/android/lineageos/vendor
rm -rf ~/android/lineageos/vendor/$vendor_path
mkdir -p $vendor_path
cp -r ~/android/lineageos/vendor/temp/* ~/android/lineageos/vendor/$vendor_path
rm -rf ~/android/lineageos/vendor/temp
cd ~/android/lineageos/

# Repeating breakfast after vendor files in case sth went wrong previously
breakfast $device
fi

# Setup environment variables
losBANNER "Env Variables..."
export USE_CCACHE=1
export ANDROID_CCACHE_SIZE="$ccache"
#export USE_NINJA=false
#export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx$ram"

if [[ $super_user = "true" ]]
then
export WITH_SU=true
fi

printenv | grep "CCACHE\|WITH_SU\|NINJA\|JACK"

# Clean build environment
losBANNER "Cleanup..."
make clean

# Repopick personal changes
if [[ $personal_repopicks = "true" ]]
then
losBANNER "Repopicking..."
repopick -f -t $repopick_topic
fi

# Actually start build
losBANNER "Building..."
brunch $device

# Enable this to copy the LineageOS installer package (zip file) to a remote server via SSH
# Specify your remote server in copy.sh
#losBANNER "Copying..."
#source copy.sh

# Shuts the machine down after the build
if [[ $shutdown = "true" ]]
then
losBANNER "Goodbye..."
sudo shutdown -h
fi
