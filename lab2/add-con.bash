#!/bin/bash

# Used to setup LAN ip addresses across all LAN machines

read -p "What is your host address?[192.168.24.x]: " y 
nmcli connection add type ethernet ifname ens224 con-name lan
nmcli connection modify lan ipv4.addresses 192.168.24.$y/24 ipv4.routes "192.168.10.0/24 192.168.24.1"
nmcli connection modify lan ipv4.method manual ipv6.method ignore autoconnect yes
