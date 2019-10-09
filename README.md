# Unattended Setup of Build Environment & Device Build for LineageOS

You want to build [LineageOS](https://lineageos.org/) for your Android device but have no clue how to do that?  
Or you are just lazy (like me)?

## Solution
This script solves this problem by offering an easy to use solution.  
Just provide the script with your settings, like which device it should build for and you are good to go.


## Usage
Clone the repository with ```git clone https://github.com/TheHADILP/lineage_build_env.git```.  
Configure your device and additional settings in ```settings.sh```.  
Start the setup and build process from a shell with ```./start.sh```.  
The script fully operates in the background, so you can close the SSH terminal session and relax.  
All output is redirected to ```setup.log```.  
The build environment setup and device build are unified in one script.  
This ensures that your build host is up-to-date before every device build.

## System Requirements
* Ubuntu 18.04
* Root privileges
* At least __100GB__ of disk storage
* 16GB RAM (recommended, you can configure less in ```settings.sh```)

## Advanced settings and features
All available settings can be configured in ```settings.sh```.

### Git
Repo wants to know who you are, when you initialize the repository.
* git_name="Your Name"
* git_email="your.email@address.com"

### LineageOS Version
Specify the LineageOS version to build.
* lineage_version="cm-14.1"

### Device
Specify the device to build for.
* device="i9300"

### Custom Local Manifest
Point to a git repository with your own local_manifest.  
With that, you can add/remove projects or specify a source for the proprietary vendor blobs.  
The repository's name has to be ```local_manifests```.  
See here for an example: https://github.com/TheHADILP/local_manifests.  
Enable feature with "true".
* custom_local_manifest="true"
* custom_local_manifest_url="https://github.com/TheHADILP/local_manifests.git"

:warning::warning::warning:**DISCLAIMER**:warning::warning::warning:  
Enabling this option disables the ```vendor_files_git``` option.  
You have two possibilities:
* Specify your proprietary vendor blobs here in the local manifest
* Disable this option and specify your proprietary vendor blobs under ```vendor_files_git```  

### Proprietary Vendor Blobs
If you have not previously enabled the ```custom_local_manifest``` option (and provided the proprietary vendor blobs in the local manifest), you can do that now with a link to a git repository.  
See here for an example: https://github.com/TheHADILP/proprietary_vendor_samsung.  
* vendor_files_git="https://github.com/TheHADILP/proprietary_vendor_samsung.git"

:warning::warning::warning:**DISCLAIMER**:warning::warning::warning:  
If the ```custom_local_manifest``` option is enabled, this option won't have any effect.  
You have two possibilities:
* Disable the ```custom_local_manifest``` option and specify your proprietary vendor blobs here
* Specify your proprietary vendor blobs directly in the local manifest


### Vendor Path
The vendor path should be the device manufacturer's name.
* vendor_path="samsung"

### CCache
Specify the size of the ccache for the build process.
* ccache="100G"

### Low RAM
If you have less than 16GB of RAM you can set the amount here.  
Enable feature with "true".
* low_ram="false"
* ram="16G"

### Super User (root)
Integrate root permissions during build time.  
Enable feature with "true".
* super_user="true"

### Custom repopicks
Repopick a topic before the build starts.  
Enable feature with "true".
* personal_repopicks="true"
* repopick_topic="i9300-personal-build"

### SCP Copy
Copy the installation zip file to another server.  
You can specify the remote's username, hostname and directory to copy the file to.  
Enable feature with "true".
* scp_copy="false"
* remote_user="ubuntu"
* remote_host="1.2.3.4"
* remote_directory="~/html"

### Shutdown
Shut the host down after the build.  
Enable feature with "true".
* shutdown="false"
