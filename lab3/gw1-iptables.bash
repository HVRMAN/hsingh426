#!/bin/bash

if [[ $EUID -ne 0 ]]
then 
	echo "This script must be run as root" 1>&2
	exit 1
fi

# POLICIES
iptables -P INPUT DROP 
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# LOOPBACK
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# ALLOW ESTABLISHED
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -m conntrack -s 192.168.24.0/29 --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m conntrack -s 172.17.24.0/29 --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# ALLOW FORWARDING
iptables -A FORWARD -i ens192 -o ens224 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i ens224 -o ens192 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i ens192 -o ens224 -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A FORWARD -i ens192 -o ens224 -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i ens224 -o ens192 -j ACCEPT
iptables -A FORWARD -i ens192 -o ens224 -j ACCEPT

# HTTP FORWARDING RULES
iptables -A FORWARD -p tcp --dport 80 --syn -j LOG --log-prefix "[iptables] HTTP SYN: "

iptables -t nat -A POSTROUTING -o ens192 -j MASQUERADE 
iptables -t nat -A PREROUTING -i ens192 -p tcp --dport 80 -d 172.17.24.1 -j DNAT --to-destination 192.168.24.2
iptables -t nat -A PREROUTING -i ens192 -p tcp --dport 80 -d 172.17.24.2 -j DNAT --to-destination 192.168.24.2
iptables -t nat -A POSTROUTING -o ens224 -p tcp --dport 80 -d 192.168.24.2 -j SNAT --to-source 192.168.24.1
iptables -t nat -A PREROUTING -i ens192 -p tcp --dport 22 -d 172.17.24.2 -j DNAT --to-destination 192.168.24.2
iptables -t nat -A POSTROUTING -o ens224 -p tcp --dport 22 -d 192.168.24.2 -j SNAT --to-source 192.168.24.1

iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

