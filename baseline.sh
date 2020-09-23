#!/usr/bin/sh

# Print hostname (a)
hostnamectl --static

# Gather Disk/Partition, Usage, Mount Points (b)
df

# List of network device name (c,d)
ip a

# OS/Kernel Version (e)
cat /etc/os-release
uname -r 

# Security mode {SELinux} (f)
sestatus

# Firewall Config (g)
sudo iptables -L -n -v

# Active Repositories (h)
sudo dnf repolist all | grep enabled

echo "RPM Packages: " 
rpm -qa | wc -l
# ADD NAME OF ALL PACKAGES TO WORD (j)

# DNS Server (k)
cat /etc/resolv.conf

# List all active users (l)
users

# Date/Time of Installation (m)
uname -a | cut -d' ' -f6-10
