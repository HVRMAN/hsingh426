#!/usr/bin/python3

from scapy.all import *

positive = []
negative = []
for i in range(1,255):
    source_ip = "192.168.24." + str(i)
    print(source_ip)
    ans = sr1(IP(src=source_ip, dst="192.168.24.80")/UDP(sport=RandShort(), dport=53)/DNS(rd=1,qd=DNSQR(qname="www.hsingh.net",qtype="A")))
    if ans:
        positive.append(i)
    else:
        negative.append(i)
print("POSITIVE TESTS: \n", positive)
print("NEGATIVES TESTS: \n", negative)

#ans2 = sr1(IP(dst="192.168.24.80")/UDP(sport=RandShort(), dport=53)/DNS(rd=1,qd=DNSQR(qname="pot.hsingh.net",qtype="A")))
