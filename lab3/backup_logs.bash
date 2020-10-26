##!/bin/bash
#
#if [[ $EUID -ne 0 ]]
#then 
#	echo "This script must be run as root" 1>&2
#	exit 1
#fi
#
#for file in messages boot.log maillog secure dnf.log
#do
#	cat /var/log/$file > ./log-backup/$file.bak
#done
#
#for file in wtmp btmp lastlog 
#do
#	utmpdump /var/log/$file > ./log-backup/$file.bak
#done
#echo "Done"
files = 
DATE=$(date | cut -d' ' -f1-3,6 | tr -d ' ')
echo $DATE
