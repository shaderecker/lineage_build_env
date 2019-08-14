#!/bin/bash

sudo apt install sshpass

cd /home/ubuntu/android/lineageos/out/target/product/$device/

comp_value=$(echo $lineage_version | cut -d '-' -f 2)

for i in *.zip; do
	if [[ $i =~ $comp_value ]]; then
		# Make sure you have access to the remote server via SSH key or password (-p 'password')
		sshpass scp -o StrictHostKeyChecking=no -r /home/ubuntu/android/lineageos/out/target/product/$device/$i $remote_user@$remote_host:$remote_directory
	fi
done
