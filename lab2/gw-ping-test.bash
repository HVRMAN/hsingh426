#!/bin/bash

echo "PPING GATEWAY (external)"
ping 172.17.10.1 -c 1

echo -e "\nPINGING GATEWAY (internal)"
ping 192.168.10.1 -c 1

