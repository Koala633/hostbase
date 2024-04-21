#!/bin/bash

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
mkdir qrcode  # We need to create this folder because github doesn't like empty folder...
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