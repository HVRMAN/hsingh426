#!/bin/bash

echo "SPR500 Lab 3 Report"

echo "FULL NAME: Harmanjit Singh"

echo "Username: hsingh426"

echo "Student ID: 149636169"

echo "ROUTING:"

ip r

echo "Http Server (port 80):"

systemctl status httpd

echo "Log file sizes:"

ls -l /var/log/{boot.log,messages,maillog,secure,wtmp,btmp,lastlog,dnf.log}

echo "Number of active services: "

systemctl list-until-files | grep enabled | wc -l

echo "Number of RPM packages installed: "

rpm -qa | wc -l

echo "Current Firewall Rules: " 

iptables -L -n -v 

echo "SELinux Execution Mode"

sestatus
