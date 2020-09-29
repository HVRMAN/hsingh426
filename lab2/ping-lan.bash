#!/bin/bash

# Ping tester for ip addresses 192.168.x.y
# Prompts will ask for x value, then ending y value
# NOTE: Tester will always ping IP addresses from 1-y.

read -p "What subnet do you want to ping? [192.168.x.0/24]: " subnet
read -p "How many hosts do you want to ping? [192.168.0.1-x/24]: " host
host=$(($host))
for i in $(seq 1 $host); do ping 192.168.24.$i -c 1; sleep 2; done
