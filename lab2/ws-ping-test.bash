#!/bin/bash

echo "PPING GATEWAY (external)"
ping 172.17.10.1 -c 1

echo -e "\nPINGING GATEWAY (internal)"
ping 192.168.10.1 -c 1

echo -e "\nPINGING VM2"
ping 192.168.10.2 -c 1


echo -e "\nPINGING VM3"
ping 192.168.10.3 -c 1

echo -e "\nPINGING VM4"
ping 192.168.10.4 -c 1
