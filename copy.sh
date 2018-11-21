#!/bin/bash

sudo apt install sshpass

cd /home/ubuntu/android/lineageos/out/target/product/i9300/

for i in *.zip; do
	if [[ $i =~ 14.1 ]]; then
		# Specify your remote server address (& user) and the destination directory here
		# Make sure you have access to the remote server via SSH key or password (-p 'password')
		# Add your SSH key for the remote server to the local ssh-agent
		sshpass scp -o StrictHostKeyChecking=no -r /home/ubuntu/android/lineageos/out/target/product/i9300/$i ubuntu@REMOTESERVER:/home/ubuntu/html/i9300
	fi
done
