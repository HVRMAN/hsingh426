#!/bin/bash

if [[ $EUID -ne 0 ]]
then
	echo "This script must be run as root" 1>&2
	exit 1
fi

iptables -F 

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# ALLOW LOOPBACK 
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# ALLOW ESTABLISHED, CONNECTED
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# LOG SYN PACKETS
iptables -A INPUT -p tcp --dport 80 --syn -j LOG --log-prefix "[iptables] HTTP SYN: "

# ALLOW SSH (INCOMING)
iptables -A INPUT -p tcp --dport 22 -m conntrack -s 192.168.24.0/29 --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m conntrack -s 172.17.24.1 --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT



# Accept ICMP 
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT


# Accept HTTP
iptables -A INPUT -p tcp --dport 80 -s 192.168.24.0/29 -j ACCEPT


