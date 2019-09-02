# Unattended Setup of Build Environment & Device Build for LineageOS

You want to build [LineageOS](https://lineageos.org/) for your Android device but have no clue how to do that?  
Or your are just lazy (like me)?

## Solution
This script solves this problem by offering an easy to use solution.  
Just provide the script with your settings, like which device it should build for and you are good to go.


## Usage
Clone the repository with ```git clone https://github.com/TheHADILP/lineage_build_env.git```.  
Configure your device and additional settings in ```settings.sh```.  
Start the setup and build process from a shell with ```./start.sh```.  
The script fully operates in the background, so you can close the SSH terminal session and relax.  
All output is redirected to ```setup.log```.  
The build environment setup and device build are unified into one script.  
This ensures, that you have all the latest and greatest software on your build host before every device build.

## Requirements
* Ubuntu 18.04
* Root privileges
* At least __100GB__ of disk storage
* 16GB RAM (recommended, you can use less, configure in ```settings.sh```)
