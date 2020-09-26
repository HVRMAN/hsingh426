#!/usr/bin/sh

# Print hostname (a)
echo "HOSTNAME:\n"
hostname

# Gather Disk/Partition, Usage, Mount Points (b)
echo "DISKS:\n"
df

# List of network device name (c,d)
echo "NETWORK INTERFACES:\n" 
ip a 

# OS/Kernel Version (e)
echo "KERNEL INFO:\n"
cat /etc/os-release
uname -r 

# Security mode {SELinux} (f)
echo "SELINUX:\n"
sestatus

# Firewall Config (g)
echo "FIREWALL:\n"
sudo iptables-save

# Active Repositories (h)
echo "ACTIVE REPOSITORIES:\n"
sudo dnf repolist all 

echo "RPM Packages:\n"
rpm -qa | wc -l
# ADD NAME OF ALL PACKAGES TO WORD (j)

# DNS Server (k)
echo "DNS SERVERS:\n"
cat /etc/resolv.conf

# List all active users (l)
echo "USERS:\n"
users

# Date/Time of Installation (m)
echo "DATE OF INSTALL:\n"
uname -v

# Hardware info

#CPU
echo "CPU INFO:\n"
lscpu

#MEM
echo "MEMORY INFO:\n"
free -h

#DEV
echo "DEVICES:\n"
mount
# Running services (o)
echo "RUNNING SERVICES:\n"
systemctl list-unit-files -t service --no-pager | grep enabled | cut -d' ' -f1

# Non-running services [Installed] (p)
echo "NON-RUNNING SERVICES:\n"
systemctl list-unit-files -t service --no-pager | grep disabled | cut -d' ' -f1

# EXTRA (q)
