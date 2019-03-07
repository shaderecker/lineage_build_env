#!/bin/bash

sudo apt install sshpass

cd /home/ubuntu/android/lineageos/out/target/product/i9300/

for i in *.zip; do
	if [[ $i =~ 14.1 ]]; then
		# Specify your remote server & user and the destination directory
		# Make sure you have access to the remote server via SSH key or password (-p 'password')
		sshpass scp -o StrictHostKeyChecking=no -r /home/ubuntu/android/lineageos/out/target/product/i9300/$i USER@REMOTESERVER:/var/www/html/i9300
	fi
done
