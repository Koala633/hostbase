#!/bin/bash


carte="$(cat hostapdcarte)"

echo "$carte"
while [ -z "${carte}" ]; do read -r ${carte}; done


ifconfig ${carte} up
sudo sysctl net.ipv4.ip_forward=1
ifconfig ${carte} 175.0.0.1 netmask 255.255.255.0
ifconfig ${carte} mtu 1400
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
sleep 2;
route add -net 175.0.0.0 netmask 255.255.255.0 gw 175.0.0.1 &> /dev/null
iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to 175.0.0.1
iptables -P FORWARD ACCEPT
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 175.0.0.1:80