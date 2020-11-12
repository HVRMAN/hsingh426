#!/usr/bin/python3

from scapy.all import *

positive = []
negative = []
for i in range(1,255):
    ans = sr1(IP(dst="192.168.24.80")/UDP(sport=RandShort(), dport=53)/DNS(rd=1,qd=DNSQR(qname="www.hsingh.net",qtype="A")))
    if ans.an.rdata=='192.168.24.80':
        positive.append(i)
    else:
        negative.append(i)
print("POSITIVE TESTS: \n", positive)
print("NEGATIVES TESTS: \n", negative)
