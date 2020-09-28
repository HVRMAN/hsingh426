#!/bin/bash
read -p "What is your host address?: " y 
nmcli connection add type ethernet ifname ens224 con-name lan
nmcli connection modify lan ipv4.addresses 192.168.24.$y ipv4.gateway 192.168.24.1
nmcli connection modify lan ipv4.method manual ipv6.method ignore autoconnect yes
