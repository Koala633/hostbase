#!/bin/bash
ifconfig wlan2 down
iw dev wlan2 set type managed
sleep 2;
ifconfig wlan2 up
sleep 2;
ifconfig wlan1 down
iw dev wlan1 set type managed
sleep 2;
ifconfig wlan1 up
sleep 2;
sudo ip link set wlan5 down
ip link set wlan5 name wlan1
sudo iw dev wlan1 set type managed
sleep 2;
sudo ip link set wlan1 up
sleep 2;
sudo ip link set wlan3 down
ip link set wlan3 name wlan2
killall hostapd
killall dhcpd
rm -rf *.txt
cd /tmp
rm -rf *.psk

