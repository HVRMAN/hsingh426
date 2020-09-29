#!/bin/bash

# Used to add routing to other subnets in lab environment

for i in $(seq 1 30)
do
	ip r a 192.168.$i.0/24 via 172.17.$i.1
done
