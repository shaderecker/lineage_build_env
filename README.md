# Unattended Setup of Build Environment & Device Build for LineageOS

You want to build [LineageOS](https://lineageos.org/) for your Android device but have no clue how to do that?  
Or your are just lazy (like me)?

## Solution
This script solves this problem by providing an easy to use solution.  
Just provide the script with your settings, like which device it should build for and you are good to go.


## Usage
Clone the repository with ```git clone https://github.com/TheHADILP/lineage_build_env.git```.  
Configure your device and additional settings in ```settings.sh``` and you are good to go.  
Start the environment setup and device build from a Shell with ```./start.sh```  
The script fully operates in the background, so you can close the SSH terminal session and relax.  
All output is redirected to ```setup.log```.  
The build environemnt setup and device build are unified into on script.  
This ensures, that you have all the latest and greatest software on your build host and continuously update before every device build.

## Requirements
* Ubuntu 18.04
* Root privileges
* At least *100GB* of disk storage
* 16GB RAM (recommended, you can use less, configure in ```settings.sh```)
