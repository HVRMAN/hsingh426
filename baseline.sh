#!/usr/bin/sh

# Print hostname (a)
echo HOSTNAME:
hostname

# Gather Disk/Partition, Usage, Mount Points (b)
echo DISKS
df

# List of network device name (c,d)
echo "NETWORK INTERFACES:" 
ip a 

# OS/Kernel Version (e)
echo "KERNEL INFO:"
cat /etc/os-release
uname -r 

# Security mode {SELinux} (f)
echo "SELINUX:"
sestatus

# Firewall Config (g)
echo "FIREWALL:"
sudo iptables-save

# Active Repositories (h)
echo "ACTIVE REPOSITORIES:"
sudo dnf repolist all 

echo "RPM Packages: " 
rpm -qa | wc -l
# ADD NAME OF ALL PACKAGES TO WORD (j)

# DNS Server (k)
echo "DNS SERVERS:"
cat /etc/resolv.conf

# List all active users (l)
echo "USERS:"
users

# Date/Time of Installation (m)
echo "DATE OF INSTALL:"
uname -v

# Hardware info
echo "HARDWARE INFO:"
#HW
lshw

#CPU
echo "CPU INFO:"
lscpu

#MEM
echo "MEMORY INFO:"
free -h

#DEV
echo "DEVICES:"
mount
# Running services (o)
echo "RUNNING SERVICES:"
systemctl list-unit-files -t service --no-pager | grep enabled | cut -d' ' -f1

# Non-running services [Installed] (p)
systemctl list-unit-files -t service --no-pager | grep disabled | cut -d' ' -f1

# EXTRA (q)
