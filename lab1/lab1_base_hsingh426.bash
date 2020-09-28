#!/usr/bin/sh

# Print hostname (a)
echo -e "\nHOSTNAME:"
hostname

# Gather Disk/Partition, Usage, Mount Points (b)
echo -e "\nDISKS:"
df

# List of network device name (c,d)
echo -e "\nNETWORK INTERFACES:" 
ip a 

# OS/Kernel Version (e)
echo -e "\nKERNEL INFO:"
cat /etc/os-release
uname -r 

# Security mode {SELinux} (f)
echo -e "\nSELINUX:"
sestatus

# Firewall Config (g)
echo -e "\nFIREWALL:"
sudo iptables-save

# Active Repositories (h)
echo -e "\nACTIVE REPOSITORIES:"
sudo dnf repolist all 

echo -e "\nRPM Packages:"
rpm -qa | wc -l
# ADD NAME OF ALL PACKAGES TO WORD (j)

# DNS Server (k)
echo -e "\nDNS SERVERS:"
cat /etc/resolv.conf

# List all active users (l)
echo -e "\nUSERS:"
users

# Date/Time of Installation (m)
echo -e "\nDATE OF INSTALL:"
uname -v

# Hardware info

#CPU
echo -e "\nCPU INFO:"
lscpu

#MEM
echo -e "\nMEMORY INFO:"
free -h

#FS/CGROUPS
echo -e "\nFILE SYSTEMS:"
mount
# Running services (o)
echo -e "\nRUNNING SERVICES:"
systemctl list-unit-files -t service --no-pager | grep enabled | cut -d' ' -f1

# Non-running services [Installed] (p)
echo -e "\nNON-RUNNING SERVICES:"
systemctl list-unit-files -t service --no-pager | grep disabled | cut -d' ' -f1

# EXTRA (q)
