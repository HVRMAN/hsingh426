#!/bin/bash

if [[ $EUID -ne 0 ]]
then 
	echo "This script must be run as root" 1>&2
	exit 1
fi

iptables -F
# POLICIES
iptables -P INPUT DROP 
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# LOOPBACK
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# ICMP RULES
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

# ALLOW ESTABLISHED
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -m conntrack -s 192.168.24.0/29 -i ens224 --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#LOG SYNC PACKETS
iptables -A FORWARD -p tcp --dport 80 --syn -j LOG --log-prefix "[iptables] HTTP SYN: "
iptables -A FORWARD -p tcp --dport 22 --syn -j LOG --log-prefix "[iptables] SSH SYN: "


# HTTP FORWARDING RULES
#iptables -t nat -A POSTROUTING -o ens224 -p tcp --dport 80 -d 192.168.24.2 -j SNAT --to-source 192.168.24.1

# ALLOW FORWARDING
# sudo iptables -A FORWARD -i ens224 -s 192.168.24.0/24 -j ACCEPT
# sudo iptables -A FORWARD -i ens192 -o ens224 -s 172.17.10.1/32 -j ACCEPT


iptables -A FORWARD -i ens192 -o ens224 -j ACCEPT
iptables -A FORWARD -i ens224 -o ens192 -j ACCEPT

# MASQUERADE ALL IPS
iptables -t nat -A POSTROUTING -o ens192 -j MASQUERADE 
iptables -t nat -A POSTROUTING -o ens244 -j MASQUERADE 
