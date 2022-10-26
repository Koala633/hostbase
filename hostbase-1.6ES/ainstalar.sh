#!/bin/bash


echo -e "\n\e[1;33m[*] Configuracion del script favor espera...\e[0m\n"

cp -R $(pwd) /tmp/
sleep 3;
cp -R /tmp/hostbase-1.6ES/paginasAQUI/* /etc/
sleep 3;
cd /etc/httpd/
rm -rf httpd.conf
cp -R /tmp/hostbase-1.6ES/httpd.conf /etc/httpd/
touch install.txt
# voir iptables et les gems
cd /tmp/hostbase-1.6ES/
ruby hostbase.rb
