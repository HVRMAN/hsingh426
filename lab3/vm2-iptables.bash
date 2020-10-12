#!/bin/bash

if [[ $EUID -ne 0 ]]
then
	echo "This script must be run as root" 1>&2
	exit 1
fi

iptables -F 

iptables -P INPUT REJECT
iptables -P FORWARD REJECT
iptables -P OUTPUT ACCEPT 

# Accept ICMP 

# Accept HTTP

# LOG SYN PACKETS


