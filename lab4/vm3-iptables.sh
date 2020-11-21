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

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# ICMP
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# DNS
iptables -A OUTPUT -p udp -d 192.168.24.0/24 --dport 53 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p udp -s 192.168.24.0/24 --sport 53 \
	-m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp -d 192.168.24.0/24 --dport 53 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -s 192.168.24.0/24 --sport 53 \
      	-m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p udp -d 172.17.0.0/16 --dport 53 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p udp -s 192.168.24.0/24 --sport 53 \
	-m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp -d 192.168.24.0/24 --dport 53 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -s 192.168.24.0/24 --sport 53 \
      	-m state --state ESTABLISHED -j ACCEPT

# SSH
# SSH
iptables -A INPUT -p tcp -s 192.168.24.0/24 --dport 22 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -s 172.17.0.1 --dport 22 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp -d 192.168.24.0/24 --sport 22 \
	-m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp --dport 22 --syn -j LOG --log-prefix "[iptables] EXTERNAL SSH SYN: "
iptables -A INPUT -p tcp --dport 22 --syn -j REJECT
iptables -A INPUT -j LOG --log-prefix "[iptables] UNKNOWN SENDER: "
iptables -A INPUT -j REJECT

